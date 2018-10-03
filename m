Received: from eggs.gnu.org ([2001:4830:134:3::10]:40338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1g7gmK-0004v8-4o
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1g7gmE-00009v-BI
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:01:24 -0400
Received: from mail-ve1eur01hn0318.outbound.protection.outlook.com
	([2a01:111:f400:fe1f::318]:19232
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1g7gmE-00009E-1T
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 09:01:18 -0400
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Wed, 3 Oct 2018 13:01:07 +0000
Message-ID: <20181003130101.GB24354@rkaganb.sw.ru>
References: <20180921082217.29481-1-rkagan@virtuozzo.com>
	<20180921082217.29481-6-rkagan@virtuozzo.com>
	<47ed971a-71c8-4a95-c1e0-697c68a7a82c@redhat.com>
In-Reply-To: <47ed971a-71c8-4a95-c1e0-697c68a7a82c@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9238C2ECD771FF41956DD025BCA27D38@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 05/10] hyperv: add synic message delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On Wed, Oct 03, 2018 at 01:06:58PM +0200, Paolo Bonzini wrote:
> On 21/09/2018 10:22, Roman Kagan wrote:
> > +typedef struct HvSintStagedMesage {
> > +    /* message content staged by hyperv_post_msg */
> > +    struct hyperv_message msg;
> > +    /* callback + data (r/o) to complete the processing in a BH */
> > +    HvSintMsgCb cb;
> > +    void *cb_data;
> > +    /* message posting status filled by cpu_post_msg */
> > +    int status;
> > +    /* passing the buck: */
> > +    enum {
> > +        /* initial state */
> > +        HV_STAGED_MSG_FREE,
> > +        /*
> > +         * hyperv_post_msg (e.g. in main loop) grabs the staged area (=
FREE ->
> > +         * BUSY), copies msg, and schedules cpu_post_msg on the assign=
ed cpu
> > +         */
> > +        HV_STAGED_MSG_BUSY,
> > +        /*
> > +         * cpu_post_msg (vcpu thread) tries to copy staged msg to msg =
slot,
> > +         * notify the guest, records the status, marks the posting don=
e (BUSY
> > +         * -> POSTED), and schedules sint_msg_bh BH
> > +         */
> > +        HV_STAGED_MSG_POSTED,
> > +        /*
> > +         * sint_msg_bh (BH) verifies that the posting is done, runs th=
e
> > +         * callback, and starts over (POSTED -> FREE)
> > +         */
> > +    } state;
> > +} HvSintStagedMesage;
>=20
> s/Mesage/Message/

:facepalm:

> > +    if (atomic_read(&staged_msg->state) !=3D HV_STAGED_MSG_POSTED) {
> > +        /* status nor ready yet (spurious ack from guest?), ignore */
> > +        return;
> > +    }
> > +
>=20
> Can this actually happen?  It seems scary...

I don't see off-hand what can stop the guest from wrmsr HV_X64_MSR_EOM
at an arbitrary moment, which AFAICS will result in this eventfd being
signaled.  I haven't seen this codepath being taken in real life but
I think it provides enough protection for the internal state from being
screwed up by such an unexpected signal.

Thanks,
Roman.
