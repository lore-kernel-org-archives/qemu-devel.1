Received: from eggs.gnu.org ([209.51.188.92]:57517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1gkNUK-0002Sj-Sj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 01:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1gkNUJ-0003Qa-SL
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 01:18:44 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:38698)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1gkNUJ-0003Nw-MF
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 01:18:43 -0500
Received: from mail-yw1-f69.google.com ([209.85.161.69])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1gkNUH-0003jq-Qf
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:18:41 +0000
Received: by mail-yw1-f69.google.com with SMTP id f10so6425281ywc.21
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 22:18:41 -0800 (PST)
MIME-Version: 1.0
References: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
In-Reply-To: <CALm7yL1oob_T+--=iW-iOQfEzJjP7reX9KrozEL2c4mYyX51jA@mail.gmail.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 18 Jan 2019 08:18:14 +0200
Message-ID: <CAATJJ0JUJvur=R8zLOg++NhSomTosJuhqHzwcr-E=HvQgm2tZg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Live migration from Qemu 2.12 hosts to Qemu 3.2
 hosts, with VMX flag enabled in the guest?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Mielke <mark.mielke@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Fri, Jan 18, 2019 at 7:33 AM Mark Mielke <mark.mielke@gmail.com> wrote:
>
> Thank you for the work on nested virtualization. Having had live migrations
> fail in the past when nested virtualization has been active, it is great to
> see that clever people have been working on this problem!
>
> My question is about whether a migration path has been considered to allow
> live migration from Qemu 2.12 hosts to Qemu 3.2 hosts, with VMX flag
> enabled in the guest?
>
> Qemu 2.12 doesn't know about the new nested state available from newer
> Linux kernels, and it might be used on a machine with an older kernel that
> doesn't make the nested state available. If Qemu 3.2 is on an up-to-date
> host with an up-to-date kernel that does support the nested state, I'd like
> to ensure we have the ability to try the migrations.
>
> In the past, I've found that:
>
> 1) If the guest had used nested virtualization before, the migration often
> fails. However, if we reboot the guest and do not use nested
> virtualization, this simplifies to...
> 2) If the guest has never used nested virtualization before, the migration
> succeeds.
>
> I would like to leverage 2) as much as possible to migrate forwards to Qemu
> 3.2 hosts (once it is available). I can normally enter the guest to see if
> 1) is likely or not, and handle these ones specially. If only 20% of the
> guests have ever used nested virtualization, then I would like the option
> to safely migrate 80% of the guests using live migration, and handle the
> 20% as exceptions.
>
> This is the 3.1 change log that got my attention:
>
>
>    - x86 machines cannot be live-migrated if nested Intel virtualization is
>    enabled. The next version of QEMU will be able to do live migration when
>    nested virtualization is enabled, if supported by the kernel.
>
>
> I believe this is the change it refers to:
>
> commit d98f26073bebddcd3da0ba1b86c3a34e840c0fb8
> Author: Paolo Bonzini <pbonzini@redhat.com>
> Date:   Wed Nov 14 10:38:13 2018 +0100
>
>     target/i386: kvm: add VMX migration blocker
>
>     Nested VMX does not support live migration yet.  Add a blocker
>     until that is worked out.
>
>     Nested SVM only does not support it, but unfortunately it is
>     enabled by default for -cpu host so we cannot really disable it.
>
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>
>
> This particular check seems very simplistic:
>
> +    if ((env->features[FEAT_1_ECX] & CPUID_EXT_VMX) && !vmx_mig_blocker) {
> +        error_setg(&vmx_mig_blocker,
> +                   "Nested VMX virtualization does not support live
> migration yet");
> +        r = migrate_add_blocker(vmx_mig_blocker, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +            error_free(vmx_mig_blocker);
> +            return r;
> +        }
> +    }
> +
>
> It fails if the flag is set, rather than if any nested virtualization has
> been used before.

Hi Mark,
I was facing the same question just recently - thanks for bringing it up.

Even more emphasized as Ubuntu (for ease of use of nested
virtualization) will enable the VMX flag by default.
That made me end up with no guest being able to migrate at all, which
as you point out clearly was not the case - they would migrate fine.
In almost all use cases it would be just the VMX flag that was set,
but never used.

I haven't thought about it before your mail, but if there would be a
way to differentiate between "VMX available" and "VMX actually used"
that would be a much better check to set the blocker.

For now I reverted above patch with the migration blocker in Ubuntu to
get the situation temporarily resolved.
I considered it a downstream thing as it is mostly triggered by our
decision to make VMX available by default which was made years ago -
that is the reason I didn't bring it up here, but now that you brought
it up it is worth the discussion for sure.

Mid term I expect that migration will work for nested guests as well
which makes me able to drop that delta then.

> I'm concerned I will end up with a requirement for *all* guests to be
> restarted in order to migrate them to the new hosts, rather than just the
> ones that would have a problem.
>
> Thoughts?
>
> Thanks!
>
> --
> Mark Mielke <mark.mielke@gmail.com>



-- 
Christian Ehrhardt
Software Engineer, Ubuntu Server
Canonical Ltd
