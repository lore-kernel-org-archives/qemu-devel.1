Received: from eggs.gnu.org ([2001:4830:134:3::10]:54326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRluB-0004qs-7H
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:28:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRlu6-0003fD-BE
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:27:59 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46028)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRlu6-0003eg-4B
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 16:27:54 -0500
Received: by mail-wr0-f194.google.com with SMTP id h1so23447538wre.12
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 13:27:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
References: <20171103152824.21948-1-marcandre.lureau@redhat.com>
	<9feece12-7197-1c6b-82dc-9b04eea134a5@redhat.com>
Message-ID: <b5e88bbe-8f51-129c-e884-c8c56465e64f@redhat.com>
Date: Wed, 20 Dec 2017 22:27:48 +0100
MIME-Version: 1.0
In-Reply-To: <9feece12-7197-1c6b-82dc-9b04eea134a5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] mux chardev events regression fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: kirill.shutemov@linux.intel.com

On 20/12/2017 16:11, Paolo Bonzini wrote:
> On 03/11/2017 16:28, Marc-André Lureau wrote:
>> Hi,
>>
>> The following patches fix and test the behaviour of mux chardev
>> events, after a regression introduced in qemu 2.8.0.
>>
>> v1->v2:
>> - fix incompatible pointer type warning spotted by patchew
>>
>> Marc-André Lureau (2):
>>   chardev: fix backend events regression with mux chardev
>>   test: add some chardev mux event tests
>>
>>  include/chardev/char.h |  1 +
>>  chardev/char-mux.c     |  8 ++++++++
>>  chardev/char.c         | 18 ++++++++++++------
>>  tests/test-char.c      | 17 +++++++++++++++++
>>  4 files changed, 38 insertions(+), 6 deletions(-)
>>
> 
> Queued, thanks.

Actually according to Peter's testing this is needed:

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 0553b48b90..567bf965cd 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -127,7 +127,9 @@ static void mux_chr_be_event(Chardev *chr, int event)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
 
-    mux_chr_send_event(d, d->focus, event);
+    if (d->focus != -1) {
+        mux_chr_send_event(d, d->focus, event);
+    }
 }
 
 static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
