Received: from eggs.gnu.org ([2001:4830:134:3::10]:42619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eonWh-0002Y0-Fq
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eonWg-0000Hx-Jw
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 04:50:55 -0500
Date: Thu, 22 Feb 2018 10:50:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180222095042.GA4147@localhost.localdomain>
References: <20180221135404.27598-1-kwolf@redhat.com>
	<20180221135404.27598-11-kwolf@redhat.com>
	<53e504b6-cb8e-e261-e7b9-c2ea9453621b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e504b6-cb8e-e261-e7b9-c2ea9453621b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/36] test-qemu-opts: Test
 qemu_opts_to_qdict_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, pkrempa@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

Am 21.02.2018 um 21:57 hat Eric Blake geschrieben:
> On 02/21/2018 07:53 AM, Kevin Wolf wrote:
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >   tests/test-qemu-opts.c | 125 +++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 125 insertions(+)
> > 
> > diff --git a/tests/test-qemu-opts.c b/tests/test-qemu-opts.c
> > index 6c3183390b..2c422abcd4 100644
> > --- a/tests/test-qemu-opts.c
> > +++ b/tests/test-qemu-opts.c
> > @@ -10,6 +10,7 @@
> >   #include "qemu/osdep.h"
> >   #include "qemu/cutils.h"
> >   #include "qemu/option.h"
> > +#include "qemu/option_int.h"
> >   #include "qapi/error.h"
> >   #include "qapi/qmp/qdict.h"
> >   #include "qapi/qmp/qstring.h"
> > @@ -868,6 +869,127 @@ static void test_opts_append(void)
> >       qemu_opts_free(merged);
> >   }
> > +static void test_opts_to_qdict_basic(void)
> > +{
> > +    QemuOpts *opts;
> > +    QDict *dict;
> > +
> > +    opts = qemu_opts_parse(&opts_list_01, "str1=foo,str2=,str3=bar,number1=42",
> > +                           false, &error_abort);
> 
> Worth any additional craziness in regards to our QemuOpts parsing, like
> str1=foo,,bar,str2... for an option containing commas, or str2=,str1=foo,
> for supplying options in a different order than the list?  But what you have
> is a good addition even if you don't tweak it.

This is not a test for parsing options string, but for converting an
already existing QemuOpts to a QDict. Parsing is already extensively
tested in /qemu-opts/opts_parse/*. I'm only using qemu_opts_parse() here
because it's the most convenient way to create a QemuOpts with multiple
options.

So the only things we need to consider in this test case are different
QemuOpts that result from the parsing. Escaped commas don't exist in
this representation any more and the associated QemuOptsList isn't
involved in the conversion to QDicts, so these wouldn't actually be new
cases for the thing we're testing here.

Kevin
