Received: from eggs.gnu.org ([2001:4830:134:3::10]:56882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dupce-0001Mq-2y
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dupca-00032y-UN
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:45:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45302)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dupca-00032P-CE
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:45:40 -0400
Date: Thu, 21 Sep 2017 08:45:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170921004534.GC13703@lemon.lan>
References: <20170920032555.18911-1-famz@redhat.com>
	<20170920032555.18911-4-famz@redhat.com>
	<91d27127-b1ba-0922-7d08-44782d277501@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91d27127-b1ba-0922-7d08-44782d277501@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 03/13] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, pbonzini@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Wed, 09/20 08:20, Eric Blake wrote:
> On 09/19/2017 10:25 PM, Fam Zheng wrote:
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  scripts/archive-source.sh | 51 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100755 scripts/archive-source.sh
> > 
> 
> > +
> > +if test -n "$submodules"; then
> > +    {
> > +        git ls-files || error "git ls-files failed"
> > +        for sm in $submodules; do
> > +            (cd $sm; git ls-files) | sed "s:^:$sm/:"
> > +            if test ${PIPESTATUS[0]} -ne 0 -o $? -ne 0; then
> 
> This relies on 'test ... -o ...' which is non-portable.  It "works"
> because there is no possible ambiguity in the contents of $PIPESTATUS
> that could cause a different parse of the test arguments, but I tend to
> discourage any use of -a/-o inside test on principle.  Sadly, writing:
> 
> if test ${PIPESTATUS[0]} -ne 0 || test $? -ne 0
> 
> has a flaw that $? is no longer what you want, at which point you would
> have to introduce a temporary variable.  But we're using bash, so you
> can instead write this as:
> 
> if test "${PIPESTATUS[@]}" != "0 0"; then

Hmm, with exactly this line here I get something like:

./scripts/archive-source.sh: line 36: test: too many arguments

But with

    if test "${PIPESTATUS[0]} ${PIPESTATUS[1]}" != "0 0"; then

it seems to work fine. What is the magic here?

Fam
