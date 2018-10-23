Received: from eggs.gnu.org ([2001:4830:134:3::10]:45321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gExkg-0000Bx-A1
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 10:33:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gExkc-0005ER-Am
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 10:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gExkc-0005DS-2h
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 10:33:42 -0400
References: <1540243704-17090-1-git-send-email-george.kennedy@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <596ea83a-279e-3a76-ead3-14aa8efe0a1d@redhat.com>
Date: Tue, 23 Oct 2018 16:33:33 +0200
MIME-Version: 1.0
In-Reply-To: <1540243704-17090-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] lsi: Reselection needed to remove
 pending commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: George Kennedy <george.kennedy@oracle.com>, famz@redhat.com, qemu-devel@nongnu.org

On 22/10/2018 23:28, George Kennedy wrote:
> As you suggested I moved the loading of "s->resel_dsp" down to the "Wai=
t Reselect"
> case. The address of the Reselection Scripts, though, is contained in "=
s->dsp - 8"
> and not in s->dnad.

Are you sure?  s->dsp - 8 should be the address of the Wait Reselect
instruction itself.  But you're right that s->dnad is the address at
which to jump "if the LSI53C895A is selected before being reselected"
(as the spec puts it) so the reselection DSP should be just s->dsp.

> The reason the timeout is needed is that under heavy IO some pending co=
mmands
> stay on the pending queue longer than the 30 second command timeout set=
 by the
> linux upper layer scsi driver (sym53c8xx). When command timeouts occur,=
 the
> upper layer scsi driver sends SCSI Abort messages to remove the timed o=
ut
> commands. The command timeouts are caused by the fact that under heavy =
IO,
> lsi_reselect() in qemu "hw/scsi/lsi53c895a.c" is not being called befor=
e the
> upper layer scsi driver 30 second command timeout goes off.
>=20
> If lsi_reselect() were called more frequently, the command timeout prob=
lem would
> probably not occur. There are a number of places where lsi_reselect() i=
s supposed
> to get called (e.g. at the end of lsi_update_irq()), but the only place=
 that I
> have observed lsi_reselect() being called is from lsi_execute_script() =
when
> lsi_wait_reselect() is called because of a SCRIPT "Wait Select" IO Inst=
ruction.

Reselection should only happen when the target needs access to the bus,
which is when I/O has finished.  There should be no need for such a
deadline; reselection should already be happening at the right time when
lsi_transfer_data calls lsi_queue_req, which in turn calls lsi_reselect.

Maybe many of the places that call lsi_irq_on_rsl(s) also need to check
s->want_resel?

Paolo
