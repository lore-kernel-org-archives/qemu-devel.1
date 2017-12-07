Received: from eggs.gnu.org ([2001:4830:134:3::10]:39495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMzRK-0004bV-HO
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eMzRE-00075K-NW
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:26 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:42084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eMzRE-00075A-Hm
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 11:54:20 -0500
Received: by mail-oi0-x241.google.com with SMTP id o64so5355723oia.9
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 08:54:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171207174832.42663bef@redhat.com>
References: <CAFEAcA-auykOKQbNcoQooNGk7Vb3wt7TH7AMA689xEj22_6KcQ@mail.gmail.com>
	<20171207174832.42663bef@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Dec 2017 16:53:59 +0000
Message-ID: <CAFEAcA9o-LyKZBZwSoz3SSPCY-sjo9e011UWy1=EwJ4U9rWYsg@mail.gmail.com>
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On 7 December 2017 at 16:48, Igor Mammedov <imammedo@redhat.com> wrote:
> On Thu, 7 Dec 2017 16:05:50 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> Hi; I'm currently writing '-cpu max' support for ARM. For that I'd
>> like to be able to do the "probe host kernel for its supported feature
>> set" in the CPU object's instance-init function, but I'd like to do
>> it just once and cache the answer. Can I rely on something or other
>> having the BQL or otherwise ensuring that two threads don't run
>> the instance_init method in parallel (eg in a hotplug situation),
>> or do I need to create and use my own mutex to protect the cached
>> answer data?
> considering cached data shouldn't change during qemu lifetime it
> shouldn't be possible for instance_init() to clash at hotplug
> time as object_new(cpu) calls serialized within monitor/qmp loop.

Right, that was my question -- are we guaranteed that anything
that calls object_new(cpu) does it with a lock?

> But why cpu's instance_init, we could cache host's value at
> configure_accelerator() time (could be different depending on accel).

I don't know if I need the information at configure_accelerator()
time (if you say "-cpu cortex-a57" then we don't need to bother
probing). The first time I know if we want to probe is when a
"-cpu host" CPU is created.

thanks
-- PMM
