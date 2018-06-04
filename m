Received: from eggs.gnu.org ([2001:4830:134:3::10]:52626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fPkZm-0006IJ-MP
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fPkZi-00062S-LE
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:10:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48714 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fPkZi-00062B-Dh
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:10:46 -0400
Date: Mon, 4 Jun 2018 16:10:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180604081028.GB31407@xz-mi>
References: <20180531051641.8473-1-peterx@redhat.com>
	<20180531051641.8473-3-peterx@redhat.com>
	<ecd9d666-8973-3f09-0ab9-eea9655e5919@redhat.com>
	<20180604045904.GA31407@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604045904.GA31407@xz-mi>
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

On Mon, Jun 04, 2018 at 12:59:04PM +0800, Peter Xu wrote:
> On Thu, May 31, 2018 at 09:42:23AM -0500, Eric Blake wrote:
> > On 05/31/2018 12:16 AM, Peter Xu wrote:
> > > This event is not really necessary.  After OOB series it might affect
> > > the timing of the script so this event may or may not be there comparing
> > > to the old *.out results.  Let's just filter it out.
> > 
> > This is worrying. Are you stating that the SHUTDOWN event can occur in a
> > different order than it used to, or is it even worse that the SHUTDOWN event
> > disappears altogether?  If enabling OOB makes the SHUTDOWN event sometimes
> > disappear, that's a regression that we should fix.  If it just makes things
> > occur in a different order, we need an explanation why that is okay.
> 
> The event might conditionally disappear in two of the 100+ qcow2
> tests.  And when it happens, it's not disappearing in all the
> testcases in the test but only some.  For example, 087 might
> conditionally fail with this:
> 
> 087 8s ... - output mismatch (see 087.out.bad)
> --- /home/peterx/git/qemu/tests/qemu-iotests/087.out    2018-06-01 18:44:22.378982462 +0800
> +++ /home/peterx/git/qemu/bin/tests/qemu-iotests/087.out.bad    2018-06-01 18:53:44.267840928 +0800
> @@ -8,7 +8,6 @@
>  {"return": {}}
>  {"error": {"class": "GenericError", "desc": "'node-name' must be specified for the root node"}}
>  {"return": {}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
> 
> 
>  === Duplicate ID ===
> @@ -53,7 +52,6 @@
>  {"return": {}}
>  {"return": {}}
>  {"return": {}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
> 
> 
>  === Missing driver ===
> 
> Firstly, it does not fail every time I run "./check -qcow2 087", but
> it might fail like 1 out of 5.  Then, it's not failing all the
> testcases in 087.  For above example, it's failing "Missing ID and
> node-name" and "Encrypted image LUKS", and it can change too.

I think I found the problem underneath.  I posted a standalone patch
to fix that here:

  [PATCH] monitor: postpone monitor_qmp_cleanup_queues

Please have a look first on that, then I'll see how I should proceed
with this series.  Thanks,

-- 
Peter Xu
