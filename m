Received: from eggs.gnu.org ([2001:4830:134:3::10]:46574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmdE-0004Py-3a
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmdB-0006dG-2e
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:48:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjmdA-0006d1-SJ
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 07:48:20 -0500
References: <33183CC9F5247A488A2544077AF19020DA1D01C2@DGGEMA505-MBX.china.huawei.com>
	<20170303120054.GB2439@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <10d66d73-a269-acb4-bc3d-2250793cba8e@redhat.com>
Date: Fri, 3 Mar 2017 13:48:16 +0100
MIME-Version: 1.0
In-Reply-To: <20170303120054.GB2439@work-vm>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug?] BQL about live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "quintela@redhat.com" <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, yanghongyang <yanghongyang@huawei.com>, Huangzhichao <huangzhichao@huawei.com>



On 03/03/2017 13:00, Dr. David Alan Gilbert wrote:
> Ouch that's pretty nasty; I remember Paolo explaining to me a while ago=
 that
> their were times when run_on_cpu would have to drop the BQL and I worri=
ed about it,
> but this is the 1st time I've seen an error due to it.
>=20
> Do you know what the migration state was at that point? Was it MIGRATIO=
N_STATUS_CANCELLING?
> I'm thinking perhaps we should stop 'cont' from continuing while migrat=
ion is in
> MIGRATION_STATUS_CANCELLING.  Do we send an event when we hit CANCELLED=
 - so that
> perhaps libvirt could avoid sending the 'cont' until then?

No, there's no event, though I thought libvirt would poll until
"query-migrate" returns the cancelled state.  Of course that is a small
consolation, because a segfault is unacceptable.

One possibility is to suspend the monitor in qmp_migrate_cancel and
resume it (with add_migration_state_change_notifier) when we hit the
CANCELLED state.  I'm not sure what the latency would be between the end
of migrate_fd_cancel and finally reaching CANCELLED.

Paolo
