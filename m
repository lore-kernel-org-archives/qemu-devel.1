Received: from eggs.gnu.org ([2001:4830:134:3::10]:34826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIFXT-0003ni-2y
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:32:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIFXS-0000qx-2S
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:32:55 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIFXR-0000pw-QE
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 10:32:53 -0400
Received: by mail-wr0-x230.google.com with SMTP id v111so48507291wrc.3
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 07:32:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87poehci7d.fsf@linaro.org>
References: <20170602160848.4913-1-alex.bennee@linaro.org>
	<20170602160848.4913-8-alex.bennee@linaro.org>
	<CAFEAcA-8wW2qBEsk-awcsRsaAKdnERmYTfwsoSMBwQqiahDfnw@mail.gmail.com>
	<87poehci7d.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 15:32:29 +0100
Message-ID: <CAFEAcA8e1uBBoauPy-JAOgTfJSrD66rNouaRHz+KvfccNouGrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v4 07/10] risu: add simple trace and
 replay support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 June 2017 at 15:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On 2 June 2017 at 17:08, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:
>>> This adds a very dumb and easily breakable trace and replay support. In
>>> --master mode the various risu ops trigger a write of register/memory
>>> state into a binary file which can be played back to an apprentice.
>>> Currently there is no validation of the image source so feeding the
>>> wrong image will fail straight away.
>>>
>>> The trace files will get very big for any appreciable sized test file
>>> and this will be addressed in later patches.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>
>>> ---
>>> v4
>>>   - fix formatting mess
>>>   - abort() instead of reporting de-sync
>>>   - don't fake return for compiler
>>> v3
>>>   - fix options parsing
>>>   - re-factored so no need for copy & paste
>>> v2
>>>   - moved read/write functions into main risu.c
>>>   - cleaned up formatting
>>>   - report more in apprentice --trace mode
>>> ---
>>>  risu.c | 97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-=
--------
>>>  1 file changed, 84 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/risu.c b/risu.c
>>> index 22571cd..137cbbf 100644
>>> --- a/risu.c
>>> +++ b/risu.c
>>> @@ -31,6 +31,7 @@
>>>  void *memblock =3D 0;
>>>
>>>  int apprentice_socket, master_socket;
>>> +int trace_file =3D 0;
>>>
>>>  sigjmp_buf jmpbuf;
>>>
>>> @@ -40,10 +41,12 @@ int test_fp_exc =3D 0;
>>>  long executed_tests =3D 0;
>>>  void report_test_status(void *pc)
>>>  {
>>> -   executed_tests +=3D 1;
>>> -   if (executed_tests % 100 =3D=3D 0) {
>>> -      fprintf(stderr,"Executed %ld test instructions (pc=3D%p)\r",
>>> -              executed_tests, pc);
>>> +   if (ismaster || trace_file) {
>>> +      executed_tests +=3D 1;
>>> +      if (executed_tests % 100 =3D=3D 0) {
>>> +         fprintf(stderr,"Executed %ld test instructions (pc=3D%p)\r",
>>> +                 executed_tests, pc);
>>> +      }
>>>     }
>>>  }
>>>
>>> @@ -54,6 +57,12 @@ int read_sock(void *ptr, size_t bytes)
>>>     return recv_data_pkt(master_socket, ptr, bytes);
>>>  }
>>>
>>> +int write_trace(void *ptr, size_t bytes)
>>> +{
>>> +   size_t res =3D write(trace_file, ptr, bytes);
>>> +   return (res =3D=3D bytes) ? 0 : 1;
>>> +}
>>> +
>>>  void respond_sock(int r)
>>>  {
>>>     send_response_byte(master_socket, r);
>>> @@ -66,9 +75,36 @@ int write_sock(void *ptr, size_t bytes)
>>>     return send_data_pkt(apprentice_socket, ptr, bytes);
>>>  }
>>>
>>> +int read_trace(void *ptr, size_t bytes)
>>> +{
>>> +   size_t res =3D read(trace_file, ptr, bytes);
>>> +   return (res =3D=3D bytes) ? 0 : 1;
>>> +}
>>> +
>>> +void respond_trace(int r)
>>> +{
>>> +   switch (r) {
>>> +      case 0: /* test ok */
>>> +      case 1: /* end of test */
>>> +         break;
>>> +      default:
>>> +         /* should not get here */
>>> +         abort();
>>> +         break;
>>> +   }
>>> +}
>>> +
>>>  void master_sigill(int sig, siginfo_t *si, void *uc)
>>>  {
>>> -   switch (recv_and_compare_register_info(read_sock, respond_sock, uc)=
)
>>> +   int r;
>>> +
>>> +   if (trace_file) {
>>> +      r =3D send_register_info(write_trace, uc);
>>> +   } else {
>>> +      r =3D recv_and_compare_register_info(read_sock, respond_sock, uc=
);
>>> +   }
>>
>> It's a bit weird that in the trace file case we send the data
>> from the master, but in the normal case we send it from
>> the apprentice end.
>
> It seemed the natural way round (master generating the "gold" stream
> that the apprentice checks). I could switch it or make the apprentice
> responsible for checking it's own work?

I guess it's not worth switching unless it causes the code to
neatly simplify because you don't need the if when both branches
of it are calling the same function...

thanks
-- PMM
