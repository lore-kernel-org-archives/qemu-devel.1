Received: from eggs.gnu.org ([2001:4830:134:3::10]:57873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5ZJ1-0006MF-BA
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:01:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d5ZIy-00021f-5s
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:01:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55412)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d5ZIx-0001zg-TS
	for qemu-devel@nongnu.org; Tue, 02 May 2017 11:01:32 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493719600-30853-1-git-send-email-thuth@redhat.com>
	<52fc3efd-55a7-af2d-ce8c-9b4565dfe6dc@de.ibm.com>
	<f2c35612-d2f5-0570-7cfa-66538882894e@redhat.com>
	<df5e01ee-a97f-7e28-9f95-840654bf48a5@de.ibm.com>
	<ac13fd46-bd6e-6a8a-2c72-cc8d683d5026@redhat.com>
Date: Tue, 02 May 2017 17:01:28 +0200
In-Reply-To: <ac13fd46-bd6e-6a8a-2c72-cc8d683d5026@redhat.com> (Paolo
	Bonzini's message of "Tue, 2 May 2017 15:22:22 +0200")
Message-ID: <87pofrfgl3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] Deprecate '-enable-kvm' and '-enable-hax'
 in favour of '-accel'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Vincent Palatin <vpalatin@chromium.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 02/05/2017 12:48, Christian Borntraeger wrote:
>>> I'm aware of the fact that likely a lot of users are still using
>>> -enable-kvm, and I did not mean that we should remove it soon yet. But
>>> IMHO we should start now to inform the users that they should slowly
>>> switch to the better option "-accel" instead, so that we could maybe
>>> remove this "-enable-xxx" stuff sometime in the distant future (let's
>>> say QEMU v4.0?).
>>
>> I come from the Linux side, where "breaking a working setup" will result in
>> an angry Linus. We certainly have not such strict rules here and we could 
>> base the decision on the question "how expensive is the maintenance
>> of this option?". I think marking it as "legacy option" is fine, but I doubt
>> that removing it will make qemu maintenance cheaper. So my preferred variant
>> is
>
> Even for Linux the rules aren't 100% black or white.  There have been
> cases where small breakage are introduced, for example 4.12 will break
> the BLKDISCARDZEROES ioctl.
>
> We shouldn't treat things are black or white here too.
>
> "-usbdevice" makes sense to deprecate because it brings together a
> complicated parsing mechanism, though perhaps we could keep it for
> simple devices such as keyboard, mouse, tablet where it's pretty surely
> in use in the wild.
>
> "-drive cyls=..." also makes sense to deprecate because it is a very
> obscure functionality.
>
> "-drive serial=..." would be nice to deprecate, but I think it's already
> less clear that it's not in use in the wild.  Probably it's still on the
> side of wanting to eventually remove it.
>
> "-net" is more complicated still.  It's almost surely in use in the
> wild, but then probably the users are fairly advanced and (with the
> provision that documentation should be updated) I guess we could
> eventually get there.
>
> But I really, really see no point in removing --enable-kvm.  It costs
> perhaps 10 lines of code that has pretty much no ramifications elsewhere
> in the code.  If anything I'd expect "-machine accel" to disappear
> before, if ever (in favor of multiple "-accel" options, e.g. "-machine
> accel=kvm:tcg" can become "-accel kvm -accel tcg".

I basically agree, except I wouldn't say "no point", but "doesn't buy us
enough to justify inconveniencing users".

What we've done before for options that have become unloved, but not
harmful, is remove them just from documentation.  Grep qemu-options.hx
for "HXCOMM Deprecated".  Let's do that for --enable-kvm and similarly
weird sugared options.
