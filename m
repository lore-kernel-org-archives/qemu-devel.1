Received: from eggs.gnu.org ([2001:4830:134:3::10]:54764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dB7IL-0006Mq-Vb
	for qemu-devel@nongnu.org; Wed, 17 May 2017 18:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dB7II-0001rq-Qw
	for qemu-devel@nongnu.org; Wed, 17 May 2017 18:19:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dB7II-0001rl-Hw
	for qemu-devel@nongnu.org; Wed, 17 May 2017 18:19:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 420C4C04B326
	for <qemu-devel@nongnu.org>; Wed, 17 May 2017 22:19:45 +0000 (UTC)
Date: Wed, 17 May 2017 19:19:41 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170517221941.GK4748@thinpad.lan.raisama.net>
References: <20170517212547.4767-1-ehabkost@redhat.com>
	<8873ed46-aa36-aae3-1f74-90f247094fab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8873ed46-aa36-aae3-1f74-90f247094fab@redhat.com>
Subject: Re: [Qemu-devel] [RFC] qmp: Return 'user_creatable' &
 'hotpluggable' fields on qom-list-types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Wed, May 17, 2017 at 05:00:29PM -0500, Eric Blake wrote:
> On 05/17/2017 04:25 PM, Eduardo Habkost wrote:
> > Currently there's no way for QMP clients to get a list of device types
> > that are really usable with -device.  This information would be useful
> > for management software and test scripts (like the device-crash-test
> > script I have submitted recently).  Interestingly, the "info qdm" HMP
> > command provides this information, but no QMP command does.
> > 
> > Add two new fields to the return value of qom-list-types:
> > "user-creatable-device" and "hotpluggable-device".  Also, add extra
> > arguments for filtering the list of types based on the new fields.
> > 
> > I'm not sure about the naming of the new command arguments.  Maybe the
> > names are too long, but I believe that "user-creatable-devices-only=false"
> > would have more obvious semantics than "user-creatable-devices=false"
> > (the latter looks ambiguous: it could mean "return only
> > non-user-creatable devices" or "return all devices").
> 
> Since this is still RFC, here's a bikeshed idea:
> 
> "just-user-creatable":false
> 
> is shorter, and still conveys whether we care about just user_creatable
> devices or all devices.
> 

We have a "user-creatable" QOM type name for backend object
types, so I believe the -device suffix is important here.

> > +++ b/qapi-schema.json
> > @@ -3034,12 +3034,24 @@
> >  #
> >  # @name: the type name found in the search
> >  #
> > +# @user-creatable-device: If true, the type is a user-creatable device that
> > +#                         can be used with the "-device" command-line option.
> > +#                         Note that this does not guarantee that the device
> > +#                         is going to be accepted by all machine-types.
> > +#                         (since 2.10)
> > +#
> > +# @hotpluggable-device: If true, the type is a hotpluggable device that can
> > +#                       be plugged using the "device_add" monitor command.
> > +#                       Note that this does not guarantee that the device can
> > +#                       be hotplugged on any machine-type. (since 2.10)
> 
> Do we need the '-device' suffix in both names?  I'm not opposed to it,
> but don't know if it is adding any useful information.

If we keep the -device suffix in "user-creatable-device", adding
the suffix to "hotpluggable" would make it more consistent.

> 
> 
> >  ##
> >  { 'command': 'qom-list-types',
> > -  'data': { '*implements': 'str', '*abstract': 'bool' },
> > +  'data': { '*implements': 'str', '*abstract': 'bool',
> > +            '*user-creatable-devices-only': 'bool', '*hotpluggable-devices-only': 'bool' },
> 
> Long line, try to keep it under 80 columns.

I will fix it. Thanks.

-- 
Eduardo
