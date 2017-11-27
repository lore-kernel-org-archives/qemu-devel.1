Received: from eggs.gnu.org ([2001:4830:134:3::10]:48296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJISo-00018n-PH
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 07:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJISl-0003aN-KC
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 07:24:42 -0500
Received: from mail-db5eur03hn0202.outbound.protection.outlook.com
	([104.47.10.202]:32160
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eJISk-0003Zo-Rb
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 07:24:39 -0500
Date: Mon, 27 Nov 2017 15:24:23 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171127122422.GC21361@rkaganb.sw.ru>
References: <20171124143206.28833-1-rkagan@virtuozzo.com>
	<64158eb0-98a0-5d06-7545-cb3a08a3c472@redhat.com>
	<20171127114552.GI32413@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171127114552.GI32413@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] util: add is_equal to UUID API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Mon, Nov 27, 2017 at 11:45:52AM +0000, Daniel P. Berrange wrote:
> On Fri, Nov 24, 2017 at 06:34:03PM +0100, Thomas Huth wrote:
> > On 24.11.2017 15:32, Roman Kagan wrote:
> > > It's going to be useful, in particular, in VMBus code massively using
> > > uuids aka GUIDs.
> > > 
> > > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> > > ---
> > >  include/qemu/uuid.h |  2 ++
> > >  tests/test-uuid.c   | 24 ++++++++++++++++++++++++
> > >  util/uuid.c         |  7 ++++++-
> > >  3 files changed, 32 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> > > index afe4840296..09489ce5c5 100644
> > > --- a/include/qemu/uuid.h
> > > +++ b/include/qemu/uuid.h
> > > @@ -48,6 +48,8 @@ void qemu_uuid_generate(QemuUUID *out);
> > >  
> > >  int qemu_uuid_is_null(const QemuUUID *uu);
> > >  
> > > +int qemu_uuid_is_equal(const QemuUUID *lhv, const QemuUUID *rhv);
> > > +
> > >  void qemu_uuid_unparse(const QemuUUID *uuid, char *out);
> > >  
> > >  char *qemu_uuid_unparse_strdup(const QemuUUID *uuid);
> > > diff --git a/tests/test-uuid.c b/tests/test-uuid.c
> > > index d3a2791fd4..c6c8148117 100644
> > > --- a/tests/test-uuid.c
> > > +++ b/tests/test-uuid.c
> > > @@ -116,6 +116,29 @@ static void test_uuid_is_null(void)
> > >      g_assert_false(qemu_uuid_is_null(&uuid_not_null_2));
> > >  }
> > >  
> > > +static void test_uuid_is_equal(void)
> > > +{
> > > +    int i;
> > > +    QemuUUID uuid;
> > > +    QemuUUID uuid_null = { };
> > > +    QemuUUID uuid_not_null = { { {
> > > +        0x58, 0x6e, 0xce, 0x27, 0x7f, 0x09, 0x41, 0xe0,
> > > +        0x9e, 0x74, 0xe9, 0x01, 0x31, 0x7e, 0x9d, 0x42
> > > +    } } };
> > > +    QemuUUID uuid_null_2 = uuid_null;
> > > +    QemuUUID uuid_not_null_2 = uuid_not_null;
> > > +
> > > +    g_assert(qemu_uuid_is_equal(&uuid_null, &uuid_null_2));
> > > +    g_assert(qemu_uuid_is_equal(&uuid_not_null, &uuid_not_null_2));
> > > +    g_assert_false(qemu_uuid_is_equal(&uuid_null, &uuid_not_null));
> > > +
> > > +    for (i = 0; i < 100; ++i) {
> > > +        qemu_uuid_generate(&uuid);
> > > +        g_assert_false(qemu_uuid_is_equal(&uuid_null, &uuid));
> > > +        g_assert_false(qemu_uuid_is_equal(&uuid_not_null, &uuid));
> > 
> > Isn't there a very low chance that the last line triggers by accident?
> > Or uuid_no_null guaranteed to not match the generated one? In the latter
> > case, a comment with a short explanation might be helpful here...
> 
> Regardless of that question, I think this is rather overkill when we are
> just validating the memcmp() works correct in qemu_uuid_is_equal. The
> for() loop  here is not really adding any value over what the earlier
> asserts already did. In fact the for() loop is arguably testing the
> qemu_uuid_generate method, so better done in a separate unit test.
> 
> IOW, I would just suggest deleting this for() loop as its adding no
> value.

Well I thought it was just too dumb to have a testcase that tests
basically nothing but memcmp, so I added this for() loop.  I guess I'd
better just drop this as a separate testcase, and merge the assertions
into test_uuid_generate instead.

Roman.
