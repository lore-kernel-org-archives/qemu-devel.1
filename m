Received: from eggs.gnu.org ([2001:4830:134:3::10]:40801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF5DA-0002Rb-Uq
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:31:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gF5D5-0003wW-TC
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:31:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gF5Cv-0003mA-FY
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 18:31:29 -0400
References: <1540243704-17090-1-git-send-email-george.kennedy@oracle.com>
	<596ea83a-279e-3a76-ead3-14aa8efe0a1d@redhat.com>
	<43e65c7a-f44d-797b-ab0c-389eaa0c0f82@oracle.com>
	<0e52d605-871e-cdac-c1ae-b0da912611ba@redhat.com>
	<adc9e69a-487b-44a6-7029-bff65f25801b@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <baf9d1db-51b7-939f-1f46-553c4fdd5939@redhat.com>
Date: Wed, 24 Oct 2018 00:31:08 +0200
MIME-Version: 1.0
In-Reply-To: <adc9e69a-487b-44a6-7029-bff65f25801b@oracle.com>
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
To: George Kennedy <george.kennedy@oracle.com>, Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On 24/10/2018 00:11, George Kennedy wrote:
>>>
>> What about "req->hba_private !=3D s->current"?=C2=A0 That should cause=
 a call
>> to lsi_queue_req, and then you can check s->want_resel in lsi_queue_re=
q.
>=20
> For the extended period of time where lsi_queue_req() is not being
> called from lsi_transfer_data(), my debug shows "s->waiting" is not "1"
> and req->hba_private is equal to s->current.

That would mean indeed that no reselection is needed---but that's wrong.

Why didn't lsi_do_command invoke lsi_queue_command?  That would set
s->current to NULL (on the SCSI level, that means the bus is freed; on
the QEMU level, the idea is that lsi_transfer_data would then start a
reselection).

Thanks,

Paolo

> req->hba_private is set to NULL in lsi_command_complete() and that's
> where I tried to add a call to lsi_reselect(), but the Scripts are not
> in the correct state to allow the call.
>=20
> lsi_transfer_data() or lsi_command_complete() are probably the 2
> potential places where a fix could be added if the Script state would
> allow it.
