Received: from eggs.gnu.org ([2001:4830:134:3::10]:51981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dupQY-0007Lw-Pl
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:33:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dupQV-0008WU-MM
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:33:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dupQV-0008Vq-GV
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 20:33:11 -0400
Date: Thu, 21 Sep 2017 08:33:06 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170921003306.GB13703@lemon.lan>
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

Okay.

> 
> > +                error "git ls-files in submodule $sm failed"
> > +            fi
> > +        done
> > +    } | grep -x -v $(for sm in $submodules; do echo "-e $sm"; done) > "$1".list
> > +else
> > +    git ls-files > "$1".list
> > +fi
> 
> At this point, $1.list has been created, even if commands failed...
> 
> > +
> > +if test $? -ne 0; then
> > +    error "failed to generate list file"
> > +fi
> 
> ...but this exits without cleanup.  If we really want it cleaned no
> matter what, it's probably better to do:
> 
> trap "status=$?; rm -f "$1".list; exit \$status" 0 1 2 3 15

Sounds good, will do.

> 
> earlier than anything that can create the file.
> 
> > +
> > +tar -cf "$1" -T "$1".list
> > +status=$?
> > +rm "$1".list
> > +if test $statue -ne 0; then
> 
> Umm, $statue is not the same as $status.

Oops, will fix.

Fam
