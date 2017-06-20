Received: from eggs.gnu.org ([2001:4830:134:3::10]:52086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNKbg-0001vB-52
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNKbd-0006y8-2f
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:58:16 -0400
Received: from mail-wr0-x232.google.com ([2a00:1450:400c:c0c::232]:32793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNKbc-0006xZ-SU
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:58:13 -0400
Received: by mail-wr0-x232.google.com with SMTP id r103so94563290wrb.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:58:11 -0700 (PDT)
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-11-alex.bennee@linaro.org>
	<CAFEAcA9oPkE_5TVO6ameGqYO9b_jGXFn-yrPp3tjfnS5x8adCw@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA9oPkE_5TVO6ameGqYO9b_jGXFn-yrPp3tjfnS5x8adCw@mail.gmail.com>
Date: Tue, 20 Jun 2017 15:58:52 +0100
Message-ID: <87tw3au2mr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v5 10/13] risu: handle trace through
 stdin/stdout
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 19 June 2017 at 11:46, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Trace files can get quite large so it would be useful to be able to
>> just capture the trace stream with stdin/stdout for processing in a
>> pipe line. The sort of case where this is useful is for building
>> static binaries where zlib support is missing for whatever reason.
>>
>> It can also be used in testing pipelines.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> ---
>>  risu.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/risu.c b/risu.c
>> index 93c274b..e94b54b 100644
>> --- a/risu.c
>> +++ b/risu.c
>> @@ -312,7 +312,11 @@ int main(int argc, char **argv)
>>
>>      if (ismaster) {
>>          if (trace) {
>> -            master_fd = open(trace_fn, O_WRONLY|O_CREAT, S_IRWXU);
>> +            if (strncmp(trace_fn, "-", strlen(trace_fn))==0) {
>
> Why not just strcmp() ?

Years of habit...

>
>> +                master_fd = fileno(stdout);
>
>    = STDOUT_FILENO;

heh , the original version used that. I'll put it back.

>
>> +            } else {
>> +                master_fd = open(trace_fn, O_WRONLY|O_CREAT, S_IRWXU);
>> +            }
>>          } else {
>>              fprintf(stderr, "master port %d\n", port);
>>              master_fd = master_connect(port);
>> @@ -320,7 +324,11 @@ int main(int argc, char **argv)
>>          return master();
>>      } else {
>>          if (trace) {
>> -            apprentice_fd = open(trace_fn, O_RDONLY);
>> +            if (strncmp(trace_fn, "-", strlen(trace_fn))==0) {
>> +                apprentice_fd = fileno(stdin);
>
>  = STDIN_FILENO;
>
>> +            } else {
>> +                apprentice_fd = open(trace_fn, O_RDONLY);
>> +            }
>>          } else {
>>              fprintf(stderr, "apprentice host %s port %d\n", hostname, port);
>>              apprentice_fd = apprentice_connect(hostname, port);
>> --
>> 2.13.0
>>
>
> thanks
> -- PMM


--
Alex Bennée
