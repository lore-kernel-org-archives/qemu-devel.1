Received: from eggs.gnu.org ([2001:4830:134:3::10]:47451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMzjp-0008Gu-4u
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:13:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMzjo-00052l-95
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:13:33 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:35562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eMzjo-00051c-2K
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:13:32 -0500
Received: by mail-oi0-x243.google.com with SMTP id 184so5407035oii.2
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 09:13:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171207170719.GT3037@localhost.localdomain>
References: <CAFEAcA-auykOKQbNcoQooNGk7Vb3wt7TH7AMA689xEj22_6KcQ@mail.gmail.com>
	<20171207174832.42663bef@redhat.com>
	<CAFEAcA9o-LyKZBZwSoz3SSPCY-sjo9e011UWy1=EwJ4U9rWYsg@mail.gmail.com>
	<20171207170719.GT3037@localhost.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Dec 2017 17:13:10 +0000
Message-ID: <CAFEAcA9fzkedj_VLeTaK-WOTLGk1RinyadRmR5FaJ44KOAQU3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] in a device or CPU instance init/realize,
 can I rely on something having the BQL or equivalent?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 7 December 2017 at 17:07, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Thu, Dec 07, 2017 at 04:53:59PM +0000, Peter Maydell wrote:
>> On 7 December 2017 at 16:48, Igor Mammedov <imammedo@redhat.com> wrote:
>> > On Thu, 7 Dec 2017 16:05:50 +0000
>> > Peter Maydell <peter.maydell@linaro.org> wrote:
>> >
>> >> Hi; I'm currently writing '-cpu max' support for ARM. For that I'd
>> >> like to be able to do the "probe host kernel for its supported feature
>> >> set" in the CPU object's instance-init function, but I'd like to do
>
> I don't think instance_init is appropriate for that, as
> object_free(object_new(t)) must be always safe to call and free
> of side-effects for all types.  Wouldn't it work if you do that
> on realize?

I think we need the information before realize, but I'll double
check. In any case the probe is safe to call and free of side-effects.
(If it fails we can stash a flag that we didn't manage to probe, which
realize can check.)

>> Right, that was my question -- are we guaranteed that anything
>> that calls object_new(cpu) does it with a lock?
>
> object_new() itself doesn't seem to be thread-safe (see
> type_initialize()), so I'm pretty sure there shouldn't be any
> object_new() calls in QEMU without the BQL being held.

Cool.

thanks
-- PMM
