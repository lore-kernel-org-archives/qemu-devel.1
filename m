Received: from eggs.gnu.org ([2001:4830:134:3::10]:41680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJHBI-0008Ha-BA
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:02:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJHBC-00005j-O3
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:02:32 -0500
Received: from mail-he1eur01hn0204.outbound.protection.outlook.com
	([104.47.0.204]:45046
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eJHBB-00004u-Uq
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 06:02:26 -0500
Date: Mon, 27 Nov 2017 14:02:11 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171127110210.GB21361@rkaganb.sw.ru>
References: <20171124143206.28833-1-rkagan@virtuozzo.com>
	<64158eb0-98a0-5d06-7545-cb3a08a3c472@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64158eb0-98a0-5d06-7545-cb3a08a3c472@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] util: add is_equal to UUID API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Fri, Nov 24, 2017 at 06:34:03PM +0100, Thomas Huth wrote:
> On 24.11.2017 15:32, Roman Kagan wrote:
> > +++ b/tests/test-uuid.c
> > @@ -116,6 +116,29 @@ static void test_uuid_is_null(void)
> >      g_assert_false(qemu_uuid_is_null(&uuid_not_null_2));
> >  }
> >  
> > +static void test_uuid_is_equal(void)
> > +{
> > +    int i;
> > +    QemuUUID uuid;
> > +    QemuUUID uuid_null = { };
> > +    QemuUUID uuid_not_null = { { {
> > +        0x58, 0x6e, 0xce, 0x27, 0x7f, 0x09, 0x41, 0xe0,
> > +        0x9e, 0x74, 0xe9, 0x01, 0x31, 0x7e, 0x9d, 0x42
> > +    } } };
> > +    QemuUUID uuid_null_2 = uuid_null;
> > +    QemuUUID uuid_not_null_2 = uuid_not_null;
> > +
> > +    g_assert(qemu_uuid_is_equal(&uuid_null, &uuid_null_2));
> > +    g_assert(qemu_uuid_is_equal(&uuid_not_null, &uuid_not_null_2));
> > +    g_assert_false(qemu_uuid_is_equal(&uuid_null, &uuid_not_null));
> > +
> > +    for (i = 0; i < 100; ++i) {
> > +        qemu_uuid_generate(&uuid);
> > +        g_assert_false(qemu_uuid_is_equal(&uuid_null, &uuid));
> > +        g_assert_false(qemu_uuid_is_equal(&uuid_not_null, &uuid));
> 
> Isn't there a very low chance that the last line triggers by accident?
> Or uuid_no_null guaranteed to not match the generated one? In the latter
> case, a comment with a short explanation might be helpful here...

No, uuid_not_null passes the same validity criteria as the generated
ones so the collision probablity is not zero.

If we had an ideal random number generator, the 122 random bits would
coincide with a probability of 1 / (2 ** 122) ~= 2e-37 which I guess is
small enough in practical terms, so as a byproduct we'll test how random
the generated uuids are.

Which BTW may need certain attention: currently qemu_uuid_generate()
uses g_random_int() while, say, vmgenid wants it "cryptographically
random"random".

But that's another story...

Roman.
