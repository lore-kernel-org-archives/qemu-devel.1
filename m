Received: from eggs.gnu.org ([2001:4830:134:3::10]:37293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gaID5-0007VW-9e
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 05:39:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gaID1-0002my-4x
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 05:39:15 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41938)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gaICz-0002gd-Cy
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 05:39:11 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181218112056.11727.96529.stgit@pasha-VirtualBox>	<20181218112142.11727.24919.stgit@pasha-VirtualBox>
	<87tvj9isxk.fsf@dusky.pond.sub.org>
In-Reply-To: <87tvj9isxk.fsf@dusky.pond.sub.org>
Date: Fri, 21 Dec 2018 13:39:11 +0300
Message-ID: <003301d49919$6966bd80$3c343880$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v8 08/20] migration: introduce icount field
 for snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Markus Armbruster' <armbru@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

> From: Markus Armbruster [mailto:armbru@redhat.com]
> Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:
> 
> > Saving icount as a parameters of the snapshot allows navigation between
> > them in the execution replay scenario.
> > This information can be used for finding a specific snapshot for rewinding
> > the recorded execution to the specific moment of the time.
> > E.g., 'reverse step' action needs to load the nearest snapshot which is
> > prior to the current moment of time .
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> [...]
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 9e45fb4..a031e5b 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2509,6 +2509,11 @@ int save_snapshot(const char *name, Error **errp)
> >      sn->date_sec = tv.tv_sec;
> >      sn->date_nsec = tv.tv_usec * 1000;
> >      sn->vm_clock_nsec = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> > +    if (replay_mode != REPLAY_MODE_NONE) {
> > +        sn->icount = replay_get_current_step();
> > +    } else {
> > +        sn->icount = -1ULL;
> > +    }
> >
> >      if (name) {
> >          ret = bdrv_snapshot_find(bs, old_sn, name);
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 762000f..7bb1727 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -26,13 +26,18 @@
> >  #
> >  # @vm-clock-nsec: fractional part in nano seconds to be used with vm-clock-sec
> >  #
> > +# @icount: Current instruction count. Appears when execution record/replay
> > +#          is enabled. Used for "time-traveling" to match the moment
> > +#          in the recorded execution with the snapshots (since 4.0)
> > +#
> >  # Since: 1.3
> >  #
> >  ##
> >  { 'struct': 'SnapshotInfo',
> >    'data': { 'id': 'str', 'name': 'str', 'vm-state-size': 'int',
> >              'date-sec': 'int', 'date-nsec': 'int',
> > -            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int' } }
> > +            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int',
> > +            '*icount': 'int' } }
> >
> >  ##
> >  # @ImageInfoSpecificQCow2EncryptionBase:
> 
> As far as I can tell, @icount is the same as ReplayInfo's @step.  But I
> had to look at the code to tell.  Please name the two consistently.
> Also consider having the documentation refer to ReplayInfo.

Thanks for noticing, renamed everything to 'icount' to match with command line option.

Pavel Dovgalyuk
