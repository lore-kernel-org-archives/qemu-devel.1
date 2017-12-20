Received: from eggs.gnu.org ([2001:4830:134:3::10]:42632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eRepf-0003ii-To
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eRepb-0000go-Os
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:54:51 -0500
Received: from mail-db5eur01hn0243.outbound.protection.outlook.com
	([104.47.2.243]:62496
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eRepb-0000fU-Dl
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 08:54:47 -0500
Date: Wed, 20 Dec 2017 16:54:33 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171220135432.GB6408@rkaganb.sw.ru>
References: <20171127124355.26015-1-rkagan@virtuozzo.com>
	<20171128074946.GG3242@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171128074946.GG3242@lemon>
Subject: Re: [Qemu-devel] [PATCH v2] util: add is_equal to UUID API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Tue, Nov 28, 2017 at 03:49:46PM +0800, Fam Zheng wrote:
> On Mon, 11/27 15:43, Roman Kagan wrote:
> > It's going to be useful, in particular, in VMBus code massively using
> > uuids aka GUIDs.
> > 
> > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> > ---
> > v1 -> v2:
> >  - drop dedicated testcase (for it was of no value) and incorporate
> >    is_null and is_equal assertions into uuid_generate testcase
> > 
> >  include/qemu/uuid.h | 2 ++
> >  tests/test-uuid.c   | 8 +++++++-
> >  util/uuid.c         | 7 ++++++-
> >  3 files changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> > index afe4840296..09489ce5c5 100644
> > --- a/include/qemu/uuid.h
> > +++ b/include/qemu/uuid.h
> > @@ -48,6 +48,8 @@ void qemu_uuid_generate(QemuUUID *out);
> >  
> >  int qemu_uuid_is_null(const QemuUUID *uu);
> >  
> > +int qemu_uuid_is_equal(const QemuUUID *lhv, const QemuUUID *rhv);
> > +
> >  void qemu_uuid_unparse(const QemuUUID *uuid, char *out);
> >  
> >  char *qemu_uuid_unparse_strdup(const QemuUUID *uuid);
> > diff --git a/tests/test-uuid.c b/tests/test-uuid.c
> > index d3a2791fd4..22b4b0727d 100644
> > --- a/tests/test-uuid.c
> > +++ b/tests/test-uuid.c
> > @@ -93,12 +93,18 @@ static inline bool uuid_is_valid(QemuUUID *uuid)
> >  
> >  static void test_uuid_generate(void)
> >  {
> > +    QemuUUID uuid_not_null = { { {
> > +        0x58, 0x6e, 0xce, 0x27, 0x7f, 0x09, 0x41, 0xe0,
> > +        0x9e, 0x74, 0xe9, 0x01, 0x31, 0x7e, 0x9d, 0x42
> > +    } } };
> >      QemuUUID uuid;
> >      int i;
> >  
> >      for (i = 0; i < 100; ++i) {
> >          qemu_uuid_generate(&uuid);
> >          g_assert(uuid_is_valid(&uuid));
> > +        g_assert_false(qemu_uuid_is_null(&uuid));
> > +        g_assert_false(qemu_uuid_is_equal(&uuid_not_null, &uuid));
> >      }
> >  }
> >  
> > @@ -168,8 +174,8 @@ static void test_uuid_unparse_strdup(void)
> >  int main(int argc, char **argv)
> >  {
> >      g_test_init(&argc, &argv, NULL);
> > -    g_test_add_func("/uuid/generate", test_uuid_generate);
> >      g_test_add_func("/uuid/is_null", test_uuid_is_null);
> > +    g_test_add_func("/uuid/generate", test_uuid_generate);
> >      g_test_add_func("/uuid/parse", test_uuid_parse);
> >      g_test_add_func("/uuid/unparse", test_uuid_unparse);
> >      g_test_add_func("/uuid/unparse_strdup", test_uuid_unparse_strdup);
> > diff --git a/util/uuid.c b/util/uuid.c
> > index dd6b5fdf05..ebf06c049a 100644
> > --- a/util/uuid.c
> > +++ b/util/uuid.c
> > @@ -41,7 +41,12 @@ void qemu_uuid_generate(QemuUUID *uuid)
> >  int qemu_uuid_is_null(const QemuUUID *uu)
> >  {
> >      static QemuUUID null_uuid;
> > -    return memcmp(uu, &null_uuid, sizeof(QemuUUID)) == 0;
> > +    return qemu_uuid_is_equal(uu, &null_uuid);
> > +}
> > +
> > +int qemu_uuid_is_equal(const QemuUUID *lhv, const QemuUUID *rhv)
> > +{
> > +    return memcmp(lhv, rhv, sizeof(QemuUUID)) == 0;
> >  }
> >  
> >  void qemu_uuid_unparse(const QemuUUID *uuid, char *out)
> > -- 
> > 2.14.3
> > 
> 
> Thanks, queued. Will send a pull request once next release dev window opens.

Ping?
