Received: from eggs.gnu.org ([208.118.235.92]:51573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luto@kernel.org>) id 1gdHpF-0002aK-FJ
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 11:51:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luto@kernel.org>) id 1gdHns-0003WI-A6
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 11:49:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:59134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <luto@kernel.org>) id 1gdHns-0003Ta-19
	for qemu-devel@nongnu.org; Sat, 29 Dec 2018 11:49:36 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
	[209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id C591F21871
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 16:49:33 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id t200so9832909wmt.0
	for <qemu-devel@nongnu.org>; Sat, 29 Dec 2018 08:49:33 -0800 (PST)
MIME-Version: 1.0
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
	<CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
	<9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca>
	<CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
	<1EF1B31A-83D8-4642-BEBF-F56E45485223@dilger.ca>
	<CAFEAcA8Yq=CEyAUer1TcaSzuzcdNi3OUi4c67B6e+OkhmcKvbg@mail.gmail.com>
	<20181229015453.GA6310@bombadil.infradead.org>
In-Reply-To: <20181229015453.GA6310@bombadil.infradead.org>
From: Andy Lutomirski <luto@kernel.org>
Date: Sat, 29 Dec 2018 08:49:19 -0800
Message-ID: <CALCETrUJn4cV+o3scP1EzYS=JA--5KUXvjuxZDbsnhXra1vrwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andreas Dilger <adilger@dilger.ca>, Florian Weimer <fw@deneb.enyo.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, libc-alpha <libc-alpha@sourceware.org>, Arnd Bergmann <arnd@arndb.de>, Eric Van Hensbergen <ericvh@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, Ron Minnich <rminnich@sandia.gov>, V9FS Developers <v9fs-developer@lists.sourceforge.net>

> On Dec 28, 2018, at 6:54 PM, Matthew Wilcox <willy@infradead.org> wrote:
>
>> On Sat, Dec 29, 2018 at 12:12:27AM +0000, Peter Maydell wrote:
>> On Fri, 28 Dec 2018 at 23:16, Andreas Dilger <adilger@dilger.ca> wrot
>>> On Dec 28, 2018, at 4:18 AM, Peter Maydell <peter.maydell@linaro.org> w=
rote:
>>>> The problem is that there is no 32-bit API in some cases
>>>> (unless I have misunderstood the kernel code) -- not all
>>>> host architectures implement compat syscalls or allow them
>>>> to be called from 64-bit processes or implement all the older
>>>> syscall variants that had smaller offets. If there was a guaranteed
>>>> "this syscall always exists and always gives me 32-bit offsets"
>>>> we could use it.
>>>
>>> The "32bitapi" mount option would use 32-bit hash for seekdir
>>> and telldir, regardless of what kernel API was used.  That would
>>> just set the FMODE_32BITHASH flag in the file->f_mode for all files.
>>
>> A mount option wouldn't be much use to QEMU -- we can't tell
>> our users how to mount their filesystems, which they're
>> often doing lots of other things with besides running QEMU.
>> (Otherwise we could just tell them "don't use ext4", which
>> would also solve the problem :-)) We need something we can
>> use at the individual-syscall level.
>
> Could you use a prctl to set whether you were running in 32 or 64 bit
> mode?  Or do you change which kind of task you're emulating too often
> to make this a good idea?


How would this work?  We already have the separate
COMPAT_DEFINE_SYSCALL entries *and* in_compat_syscall(). Now we=E2=80=99d h=
ave
a third degree of freedom.

Either the arches people care about should add reasonable ways to
issue 32-bit syscalls from 64-bit mode or there should be an explicit
way to ask for the 32-bit directory offsets.
