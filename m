Received: from eggs.gnu.org ([2001:4830:134:3::10]:57780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dda72-0006F7-Pm
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dda4n-0002Gl-8H
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:45:14 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dda4m-0002DB-P7
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 06:43:28 -0400
Received: by mail-wr0-f181.google.com with SMTP id y43so15272900wrd.3
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 03:43:27 -0700 (PDT)
References: <526F8457.5040907@kamp.de> <526F8701.2030906@redhat.com>
	<1aefefcb-5ea7-e91f-bf11-4cde9ccd0f92@kamp.de>
	<3709ecdf-bcee-15e4-036a-9be9446db9bc@redhat.com>
	<33560059-ae3d-9ee9-dab7-9f992f8d913c@kamp.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <db37ed08-223f-91c8-b72d-3dede381ea6a@redhat.com>
Date: Fri, 4 Aug 2017 12:43:22 +0200
MIME-Version: 1.0
In-Reply-To: <33560059-ae3d-9ee9-dab7-9f992f8d913c@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Prohibit Windows from running in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 04/08/2017 12:27, Peter Lieven wrote:
> Am 04.08.2017 um 12:23 schrieb Paolo Bonzini:
>> On 04/08/2017 11:58, Peter Lieven wrote:
>>> Am 29.10.2013 um 10:59 schrieb Paolo Bonzini:
>>>> Il 29/10/2013 10:48, Peter Lieven ha scritto:
>>>>> Hi all,
>>>>>
>>>>> this question might seem a bit weird, but does anyone see a good way to
>>>>> avoid
>>>>> that Windows is able to boot inside qemu?
>>>>>
>>>>> We have defined several profiles for different operation systems and I want
>>>>> to avoid that someone chooses Linux and then installs Windows within
>>>>> a VM. Reason is licensing.
>>>> Patch QEMU to crash when Hyper-V extensions are enabled...
>>> Hi all,
>>>
>>> this is an old topic that has become important for me again recently.
>>> Now all Linux versions should be able to detect KVM even if Hyper-V is enabled.
>>>
>>> But how do I detect from Qemu userspace that Hyper-V is enabled?
>> Maybe a better one: make KVM crash the guest if CR8 is nonzero on a
>> vmexit.  Linux doesn't use it, Windows should not survive long.
> 
> You mean the kvm kernel module? Or can I access this register also
> from Qemu on any call that is handled in userspace? It would be easier
> to have a cmdline option to Qemu than an option to a kernel module.

Yes, the kernel module.  Accessing it in QEMU requires
cpu_synchronize_state so it's slow.  However, you could piggyback on
some other functionality that is never used by Linux to do the check,
for example the RTC I/O port.

That is, in the RTC I/O port code you call cpu_synchronize_state and
check CR8.

Paolo

>> Warning, I don't know if UEFI firmware uses CR8.
> 
> UEFI firmware is not important in this case.
> Do you know if FreeBSD, OpenBSD or NetBSD use it?
> 
> 
> Thank for your ideas,
> Peter
> 
