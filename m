Received: from eggs.gnu.org ([2001:4830:134:3::10]:33958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctFub-0007Os-Fx
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 11:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ctFua-0002eN-NN
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 11:53:29 -0400
References: <20170225193155.447462-1-vsementsov@virtuozzo.com>
	<20170225193155.447462-4-vsementsov@virtuozzo.com>
	<20170307095323.GB5871@noname.str.redhat.com>
	<20170328105544.GE2509@work-vm>
	<20170328110900.GB11725@noname.redhat.com>
	<20170328111315.GF2509@work-vm>
	<20170328120900.GC11725@noname.redhat.com>
	<4ed9821c-d19e-70fe-c7e5-fc89756b59f5@virtuozzo.com>
	<09db3476-b1e4-fa80-6d83-d5da0a06bdfc@redhat.com>
	<20170329152941.GC2501@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dd9b5dda-eb13-a184-9acc-839e966a103f@redhat.com>
Date: Wed, 29 Mar 2017 17:53:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170329152941.GC2501@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] savevm: fix savevm after migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, quintela@redhat.com, mreitz@redhat.com, peter.maydell@linaro.org, den@openvz.org, jsnow@redhat.com, lirans@il.ibm.com



On 29/03/2017 17:29, Dr. David Alan Gilbert wrote:
>>> 'abort' is not very good too I think. migration is completed, nothing to
>>> abort.. (may be successful migration to file for suspend, some kind of
>>> vm cloning, etc)
>> There is already migrate_cancel.  Does it make sense to make it
>> reactivate fds if migration is completed?
> It's potentially racy to do that.
> Imagine if your migration is almost finished and you issue a migrate_cancel,
> what happens?
> Maybe it cancelled it.
> Maybe it just completed in time - and you really better not be accessing
> the disks on the source unless you're sure the destination isn't running.

If you want to avoid races, you probably have to use -S anyway on the
destination and do more handshaking between source and destination.  But
yes, just to be safe it'd be better to add a new flag (-f for HMP,
'cancel-completed-migration':true for QMP or something like that).

Paolo
