Received: from eggs.gnu.org ([2001:4830:134:3::10]:51718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fPhaZ-0006R3-Q9
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:59:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fPhaU-0004R7-UF
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:59:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42132 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fPhaU-0004R1-NR
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 00:59:22 -0400
Date: Mon, 4 Jun 2018 12:59:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180604045904.GA31407@xz-mi>
References: <20180531051641.8473-1-peterx@redhat.com>
	<20180531051641.8473-3-peterx@redhat.com>
	<ecd9d666-8973-3f09-0ab9-eea9655e5919@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ecd9d666-8973-3f09-0ab9-eea9655e5919@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 2/4] tests: iotests: don't compare
 SHUTDOWN event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Auger <eric.auger@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, May 31, 2018 at 09:42:23AM -0500, Eric Blake wrote:
> On 05/31/2018 12:16 AM, Peter Xu wrote:
> > This event is not really necessary.  After OOB series it might affect
> > the timing of the script so this event may or may not be there comparing
> > to the old *.out results.  Let's just filter it out.
> 
> This is worrying. Are you stating that the SHUTDOWN event can occur in a
> different order than it used to, or is it even worse that the SHUTDOWN event
> disappears altogether?  If enabling OOB makes the SHUTDOWN event sometimes
> disappear, that's a regression that we should fix.  If it just makes things
> occur in a different order, we need an explanation why that is okay.

The event might conditionally disappear in two of the 100+ qcow2
tests.  And when it happens, it's not disappearing in all the
testcases in the test but only some.  For example, 087 might
conditionally fail with this:

087 8s ... - output mismatch (see 087.out.bad)
--- /home/peterx/git/qemu/tests/qemu-iotests/087.out    2018-06-01 18:44:22.378982462 +0800
+++ /home/peterx/git/qemu/bin/tests/qemu-iotests/087.out.bad    2018-06-01 18:53:44.267840928 +0800
@@ -8,7 +8,6 @@
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "'node-name' must be specified for the root node"}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}


 === Duplicate ID ===
@@ -53,7 +52,6 @@
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}


 === Missing driver ===

Firstly, it does not fail every time I run "./check -qcow2 087", but
it might fail like 1 out of 5.  Then, it's not failing all the
testcases in 087.  For above example, it's failing "Missing ID and
node-name" and "Encrypted image LUKS", and it can change too.

> 
> > 
> > Since some of the scripts are using qmp-pretty, we need some trick in
> > the filtering script to make sure sed works for multiple lines to
> > explicitly mask out this event.
> > 
> > CC: John Snow <jsnow@redhat.com>
> > CC: Max Reitz <mreitz@redhat.com>
> > CC: Kevin Wolf <kwolf@redhat.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> 
> > +++ b/tests/qemu-iotests/067.out
> > @@ -70,6 +70,7 @@ Testing: -drive file=TEST_DIR/t.IMGFMT,format=IMGFMT,if=none,id=disk -device vir
> >       }
> >   }
> > +
> >   === -drive/device_add and device_del ===
> 
> Why is this blank line being added (multiple times in this file)?  Is there
> something about the new filter that isn't quite stripping all the newlines
> when encountering the SHUTDOWN event in pretty form?
> 
> Aha - it's because test 067 is already doing a very similar filtering of
> events.  Can we reduce the code duplication by promoting _filter_qmp_events
> from there into common.filter (as a separate patch)?

Yeah, can do.

> 
> > +++ b/tests/qemu-iotests/common.filter
> > @@ -88,7 +88,10 @@ _filter_qmp()
> >       sed -e 's#\("\(micro\)\?seconds": \)[0-9]\+#\1 TIMESTAMP#g' \
> >           -e 's#^{"QMP":.*}$#QMP_VERSION#' \
> >           -e '/^    "QMP": {\s*$/, /^    }\s*$/ c\' \
> > -        -e '    QMP_VERSION'
> > +        -e '    QMP_VERSION' | \
> > +    tr '\n' '\r' | \
> > +    sed -e 's/{\s*"timestamp":\s*{\s*"seconds":\s*TIMESTAMP,\s*"microseconds":\s*TIMESTAMP\s*},\s*"event":\s*"SHUTDOWN",\s*"data":\s*{\s*"guest":\s*false\s*}\s*}\s//' | \
> 
> Really long line. This should do the same:
> 
> sed -e 's/\r{\(\r[^}]\|[^\r]\)*SHUTDOWN\(\r[^}]\|[^\r]\)*\r}//'
> 
> where the \(\r[^}]\|[^\r]\)* subpattern picks up all line breaks that do not
> end the current top-level {}, as well as any non-line breaks.
> 
> In fact, if you like my suggestion about promoting the filter from 67 into
> common.filter, we have two use cases: filter a single pretty-printed filter,
> and filter ANY pretty-printed filter.  Maybe we do that as follows:
> 
> # $1 is a regex of event names to filter; leave empty to filter all
> _filter_qmp_events()
> {
>     fluff='\(\r[^}]\|[^\r]\)*'
>     tr \\n \\r | \
>     sed -e "s/$fluff"'"event": "'"$1$fluff\\r}//" \
>   | tr \\r \\n
> }
> 
> at which point '_filter_qmp_events SHUTDOWN' works in this patch, and
> '_filter_qmp_events' works for 067.  [Untested, but hopefully that gives you
> some ideas to play with]

Regex magic.  Thanks for the lesson. :)

-- 
Peter Xu
