Received: from eggs.gnu.org ([2001:4830:134:3::10]:54084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYbi8-0006gl-7e
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cYbi3-0002tA-Vb
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:55:16 -0500
Received: from mail-vk0-x22b.google.com ([2607:f8b0:400c:c05::22b]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cYbi3-0002rd-RJ
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:55:11 -0500
Received: by mail-vk0-x22b.google.com with SMTP id r136so241299653vke.1
	for <qemu-devel@nongnu.org>; Tue, 31 Jan 2017 08:55:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7df08f03-9244-a246-ff89-fc0ffb69c736@redhat.com>
References: <1485873796-15095-1-git-send-email-mst@redhat.com>
	<87zii75jze.fsf@dusky.pond.sub.org>
	<20170131172752-mutt-send-email-mst@kernel.org>
	<87o9yn2oy9.fsf@dusky.pond.sub.org>
	<7df08f03-9244-a246-ff89-fc0ffb69c736@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Jan 2017 16:54:50 +0000
Message-ID: <CAFEAcA-PLbA80Hftk+M1DbfCv4vpnSsyiGCynspO9eiyBbsLiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] QEMU_BUILD_BUG_ON: use __COUNTER__
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 31 January 2017 at 16:37, Eric Blake <eblake@redhat.com> wrote:
> On 01/31/2017 10:07 AM, Markus Armbruster wrote:
>>> I tried that first thing.
>>> This generates lots of warnings if you have multiple users
>>> within a function: gcc is unhappy about the redundant extern
>>> declarations.
>>
>> #define QEMU_BUILD_BUG_ON(x) \
>>     _Pragma("GCC diagnostic push") \
>>     _Pragma("GCC diagnostic ignored \"-Wredundant-decls\"") \
>>     extern char qemu_build_bug_on_[QEMU_BUILD_BUG_ON_ZERO((x))] __attribute__((unused)); \
>>     _Pragma("GCC diagnostic pop")
>
> Do we know if pragma GCC diagnostic push is supported in our minimum
> compiler requirements (gcc 4.1, and presumably clang just ignores the
> pragma)?

Nope; that's gcc 4.6 or newer. They're also a bit flaky between
gcc and clang because they rely on the warning being the same
in both cases. Using them in QEMU_BUILD_BUG_ON would be
massively overkill, especially since gcc 4.6 and on support
_Static_assert() which will get us better error messages
than this stuff.

thanks
-- PMM
