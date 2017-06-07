Received: from eggs.gnu.org ([2001:4830:134:3::10]:34937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIZvQ-0007eE-HK
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dIZvP-0008LO-Kt
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 08:19:00 -0400
Date: Wed, 7 Jun 2017 13:18:41 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170607121840.GE2099@work-vm>
References: <20170606052438.35405-1-haoqf@linux.vnet.ibm.com>
	<20170606052438.35405-2-haoqf@linux.vnet.ibm.com>
	<20170606124953.GD5448@noname.redhat.com>
	<a908cc58-3001-0d8a-0415-887b5cbae4e7@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a908cc58-3001-0d8a-0415-887b5cbae4e7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qemu/migration: fix the double free
 problem on from_src_file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, liujbjl@linux.vnet.ibm.com, famz@redhat.com

* QingFeng Hao (haoqf@linux.vnet.ibm.com) wrote:
>=20
>=20
> =E5=9C=A8 2017/6/6 20:49, Kevin Wolf =E5=86=99=E9=81=93:
> > Am 06.06.2017 um 07:24 hat QingFeng Hao geschrieben:

<snip>

> > I can't tell for postcopy_ram_listen_thread() - commit 660819b didn't
> > seem to remove a qemu_fclose() call there, but I can't see one left
> > behind either. Was the file leaked before commit 660819b or am I
> > missing something?
> I don't think so because loadvm_postcopy_handle_listen creates thread
> postcopy_ram_listen_thread
> and passes mis->from_src_file as its arg, which will be closed by
> migration_incoming_state_destroy.
> What confuses me is in the series function calls of qemu_loadvm_state_m=
ain
> etc, argument f looks
> to be redundant as mis already contains from_src_file which equals to f=
.

In postcopy qemu_loadvm_state_main is called with two different file
arguments but the same mis argument;  see loadvm_handle_cmd_packaged for
the other case where it's called on a packaged-file blob.

> Furthermore, mis may be
> also redundant as it can be got via migration_incoming_get_current. Tha=
nks!

We keep changing our minds about the preferred style.  Sometimes we
think it's best to pass the pointer, sometimes we think it's best
to call get_current.

Dave

> >=20
> > Kevin
> >=20
>=20
> --=20
> Regards
> QingFeng Hao
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
