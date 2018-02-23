Received: from eggs.gnu.org ([2001:4830:134:3::10]:48279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1epCPo-0002eU-WC
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1epCPn-0004x4-K3
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:25:28 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1epCPn-0004tN-6y
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:25:27 -0500
Received: by mail-wm0-x244.google.com with SMTP id h21so4334850wmd.1
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 04:25:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <bbf391fa-acf1-16bd-e6e9-336b977160e8@redhat.com>
References: <20180215212552.26997-1-marcandre.lureau@redhat.com>
	<bbf391fa-acf1-16bd-e6e9-336b977160e8@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Feb 2018 13:25:25 +0100
Message-ID: <CAJ+F1CKUExi5XAOpF2yFyPah66=0KvEkUbRNASergSS6smkVoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] vhost-user-test and leak fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Fri, Feb 23, 2018 at 12:37 PM, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> On 15/02/2018 22:25, Marc-Andr=C3=A9 Lureau wrote:
>> Hi,
>>
>> The following patches fix a regression introduced in commit
>> 218bb57dd79d that prevent ASAN from being detected & used.  There is
>> also a works around for a GCC ASAN optimization bug. A few test leaks
>> are fixed, and a few patches reenable vhost-user memfd test fixing the
>> recent race bug that was identified in the previous version.
>>
>> Marc-Andr=C3=A9 Lureau (6):
>>   build-sys: fix -fsanitize=3Daddress check
>>   lockable: workaround GCC link issue with ASAN
>>   vhost-user-test: add back memfd check
>>   vhost-user-test: do not hang if chardev creation failed
>>   ahci-test: fix opts leak of skip tests
>>   sdhci-test: fix leaks
>>
>>  include/qemu/lockable.h |  2 +-
>>  tests/ahci-test.c       |  1 +
>>  tests/sdhci-test.c      |  2 ++
>>  tests/vhost-user-test.c | 94 +++++++++++++++++++++++++++++++++++-------=
-------
>>  configure               | 22 ++++++------
>>  5 files changed, 83 insertions(+), 38 deletions(-)
>>
>
> Queued 1-2-5-6, not really confident enough in what's going on with
> vhost-user-test. :)

It hangs when chardev creation fails. Which is apparent when running
with --debug-log. That's also why I added "vhost-user-test: do not
hang if chardev creation failed". The problem comes from reusing
socket location without waiting for the idle cleanup. Using different
socket path solves it (vhost-user-test: add back memfd check)

Maxime, could you help review those patches?

thanks

--=20
Marc-Andr=C3=A9 Lureau
