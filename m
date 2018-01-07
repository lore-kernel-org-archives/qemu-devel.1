Received: from eggs.gnu.org ([2001:4830:134:3::10]:57824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eYBHf-0005VV-2e
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 08:46:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1eYBHd-00053I-HR
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 08:46:43 -0500
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:45195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1eYBHd-00050p-8R
	for qemu-devel@nongnu.org; Sun, 07 Jan 2018 08:46:41 -0500
Received: by mail-wm0-x232.google.com with SMTP id 9so9747583wme.4
	for <qemu-devel@nongnu.org>; Sun, 07 Jan 2018 05:46:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <225d94e2-feb5-6081-faa9-4d0a028e0dfc@redhat.com>
References: <1515045675-6993-1-git-send-email-zhangckid@gmail.com>
	<1515045675-6993-11-git-send-email-zhangckid@gmail.com>
	<225d94e2-feb5-6081-faa9-4d0a028e0dfc@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Sun, 7 Jan 2018 21:46:39 +0800
Message-ID: <CAK3tnv+QCcHGKN_Ly+DY2jKJO=Gz=zKrd5UwAYHvgrbPRzWXvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RESEND V3 10/16] qmp event: Add COLO_EXIT
 event to notify users while exited COLO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>

On Thu, Jan 4, 2018 at 5:10 PM, Eric Blake <eblake@redhat.com> wrote:

> On 01/04/2018 12:01 AM, Zhang Chen wrote:
> > From: zhanghailiang <zhang.zhanghailiang@huawei.com>
> >
> > If some errors happen during VM's COLO FT stage, it's important to
> > notify the users of this event. Together with 'x_colo_lost_heartbeat',
>
> Isn't that spelled x-colo-lost-heartbeat in QMP?
>

Yes, I will fix this comments in next version.


>
> > Users can intervene in COLO's failover work immediately.
> > If users don't want to get involved in COLO's failover verdict,
> > it is still necessary to notify users that we exited COLO mode.
> >
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
> > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> > ---
>
> Focusing on just the UI:
>
>
> > +++ b/qapi-schema.json
> > @@ -2921,6 +2921,27 @@
> >  { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
> >
> >  ##
> > +# @COLO_EXIT:
> > +#
> > +# Emitted when VM finishes COLO mode due to some errors happening or
> > +# at the request of users.
> > +#
> > +# @mode: which COLO mode the VM was in when it exited.
> > +#
> > +# @reason: describes the reason for the COLO exit.
> > +#
> > +# Since: 2.11
>
> You've missed 2.11; this should be 2.12.
>

I got it.


>
> > +#
> > +# Example:
> > +#
> > +# <- { "timestamp": {"seconds": 2032141960, "microseconds": 417172},
> > +#      "event": "COLO_EXIT", "data": {"mode": "primary", "reason":
> "request" } }
> > +#
> > +##
> > +{ 'event': 'COLO_EXIT',
> > +  'data': {'mode': 'COLOMode', 'reason': 'COLOExitReason' } }
>
> Since COLOMode is in migration.json, shouldn't this 'event' declaration
> live there as well?
>

OK, I will move this to migration.json like the COLOMode in next version.



>
> > +
> > +##
> >  # @ACPI_DEVICE_OST:
> >  #
> >  # Emitted when guest executes ACPI _OST method.
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 03f57c9..f7b2cc6 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -854,6 +854,19 @@
> >  ##
> >  { 'enum': 'FailoverStatus',
> >    'data': [ 'none', 'require', 'active', 'completed', 'relaunch' ] }
> > +##
> > +# @COLOExitReason:
> > +#
> > +# The reason for a COLO exit
> > +#
> > +# @request: COLO exit is due to an external request
> > +#
> > +# @error: COLO exit is due to an internal error
> > +#
> > +# Since: 2.11
>
> 2.12
>

I got it .

Thanks
Zhang Chen


>
> > +##
> > +{ 'enum': 'COLOExitReason',
> > +  'data': [ 'request', 'error' ] }
> >
> >  ##
> >  # @x-colo-lost-heartbeat:
> >
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
>
>
