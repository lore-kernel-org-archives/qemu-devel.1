Received: from eggs.gnu.org ([2001:4830:134:3::10]:35815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTRnw-0008WQ-HZ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:56:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTRnv-0003Hb-L3
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:56:44 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTRnv-0003Gh-FX
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:56:43 -0400
Received: by mail-oi0-x244.google.com with SMTP id 188-v6so5510142oid.12
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 05:56:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <874li5leel.fsf@dusky.pond.sub.org>
References: <20180524044454.11792-1-peterx@redhat.com>
	<20180524044454.11792-3-peterx@redhat.com>
	<87r2lbkt5u.fsf@dusky.pond.sub.org>
	<dfb61dcd-c180-1307-bf9d-086aa15478ec@redhat.com>
	<874li5leel.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Jun 2018 13:56:22 +0100
Message-ID: <CAFEAcA9DGGopD_zhZyzCUmN_jcRB=y2jmN-JEupHt_jcHtyaYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/2] intel-iommu: start to use
 error_report_once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>

On 14 June 2018 at 13:51, Markus Armbruster <armbru@redhat.com> wrote:
> Auger Eric <eric.auger@redhat.com> writes:
>
>> Hi,
>> On 06/13/2018 10:05 AM, Markus Armbruster wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> Replace existing trace_vtd_err() with error_report_once() then stderr
>>>> will capture something if any of the error happens, meanwhile we don't
>>>> suffer from any DDOS.  Then remove the trace point.  Since at it,
>>>> provide more information where proper (now we can pass parameters into
>>>> the report function).
>>>>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>> ---
>>>>  hw/i386/intel_iommu.c | 59 ++++++++++++++++++++++++------------------=
-
>>>>  hw/i386/trace-events  |  1 -
>>>>  2 files changed, 33 insertions(+), 27 deletions(-)
>>>
>>> Michael, would you give your Reviewed-by or Acked-by?  I'd take the
>>> series through my tree then.
>>>
>>> [...]
>>>
>> Sorry to enter this thread at this late stage. Just one question: on the
>> smmuv3 emulation code, Peter (Maydell) urged me to use
>> qemu_log_mask(LOG_GUEST_ERROR, ...) whenever the error was triggered by
>> a guest bad behavior. So what is the final guidance to avoid the DOS you
>> mention?
>
> Does the user need to know about the error condition?
>
> If yes, we should tell him.  Logging is not telling.
>
> Peter, what do you think?

My view is that "guest does something stupid" should be
LOG_GUEST_ERROR, because (a) maybe you'd like to know about it
but (b) usually you don't unless you happen to be the person
trying to develop or debug the guest OS, in which case you can
turn on the logging to help you in that debugging task.

thanks
-- PMM
