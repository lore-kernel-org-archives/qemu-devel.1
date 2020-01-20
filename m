Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F550C33CA1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4952A20684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 09:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJ4zhkE6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4952A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itT1e-0006Ah-5C
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 04:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1itSzw-0004HZ-Ay
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:05:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1itSzs-0000bZ-Fa
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:05:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32752
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1itSzs-0000bB-8x
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 04:05:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579511123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjgLIQLZnEWnfHxE8zkHcHRPypW+wAkf9hxN1SAf6oA=;
 b=BJ4zhkE6/mMB2h5HipmqPvxyyE7aRe+PthRhVKvBKy2/+86S7E6oREtjrnIy6uO9cwwQ1a
 SpeN4tOx7TRdWfpCVNmqGIMoMyaVYE+3d10cFPIWTHHVDvyjpko9WXrinVR7wfULCM4eSi
 hgzGPR8AKhWaIZwDKsPF5T0vIR4Gqxw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-SLjUsWGTOpWOYrfMdEq-XA-1; Mon, 20 Jan 2020 04:05:22 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB3A218AAFA1;
 Mon, 20 Jan 2020 09:05:20 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99A3A89E95;
 Mon, 20 Jan 2020 09:05:18 +0000 (UTC)
Date: Mon, 20 Jan 2020 09:05:15 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: fengzhimin <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 12/12] migration/rdma: only register the virt-ram
 block for MultiRDMA
Message-ID: <20200120090515.GA2827@work-vm>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-13-fengzhimin1@huawei.com>
 <20200117185227.GS3209@work-vm>
 <03C2A65461456D4EBE9E6D4D0D96C583FC1465@DGGEMI529-MBX.china.huawei.com>
MIME-Version: 1.0
In-Reply-To: <03C2A65461456D4EBE9E6D4D0D96C583FC1465@DGGEMI529-MBX.china.huawei.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: SLjUsWGTOpWOYrfMdEq-XA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "quintela@redhat.com" <quintela@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "jemmy858585@gmail.com" <jemmy858585@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* fengzhimin (fengzhimin1@huawei.com) wrote:
> OK, I will modify it.
>=20
> Due to the mach-virt.ram is sent by the multiRDMA channels instead of the=
 main channel, it don't to register on the main channel.

You might be OK if instead  of using the name, you use a size threshold;
e.g. you use the multirdma threads for any RAM block larger than say
128MB.

> It takes a long time to register the mach-virt.ram for VM with large capa=
city memory, so we shall try our best not to register it.

I'm curious why, I know it's expensive to register RAM blocks with rdma
code; but I thought that would just be the first time; it surprises me
that registering it with a 2nd RDMA channel is as expensive.

But then that makes me ask a 2nd question; is your performance increase
due to multiple threads or is it due to the multiple RDMA channels?
COuld you have multiple threads but still a single RDMA channel
(and with sufficient locking) still get the performance?

Dave

> Thanks for your review.
>=20
> Zhimin Feng
>=20
> -----Original Message-----
> From: Dr. David Alan Gilbert [mailto:dgilbert@redhat.com]=20
> Sent: Saturday, January 18, 2020 2:52 AM
> To: fengzhimin <fengzhimin1@huawei.com>
> Cc: quintela@redhat.com; armbru@redhat.com; eblake@redhat.com; qemu-devel=
@nongnu.org; Zhanghailiang <zhang.zhanghailiang@huawei.com>; jemmy858585@gm=
ail.com
> Subject: Re: [PATCH RFC 12/12] migration/rdma: only register the virt-ram=
 block for MultiRDMA
>=20
> * Zhimin Feng (fengzhimin1@huawei.com) wrote:
> > From: fengzhimin <fengzhimin1@huawei.com>
> >=20
> > The virt-ram block is sent by MultiRDMA, so we only register it for=20
> > MultiRDMA channels and main channel don't register the virt-ram block.
> >=20
> > Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
>=20
> You can't specialise on the name of the RAMBlock like that.
> 'mach-virt.ram' is the name specific to just the main ram on just aarch's=
 machine type;  for example the name on x86 is completely different and if =
you use NUMA or hotplug etc it would also be different on aarch.
>=20
> Is there a downside to also registering the mach-virt.ram on the main cha=
nnel?
>=20
> Dave
>=20
> > ---
> >  migration/rdma.c | 140=20
> > +++++++++++++++++++++++++++++++++++++----------
> >  1 file changed, 112 insertions(+), 28 deletions(-)
> >=20
> > diff --git a/migration/rdma.c b/migration/rdma.c index=20
> > 0a150099e2..1477fd509b 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -618,7 +618,9 @@ const char *print_wrid(int wrid);  static int=20
> > qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader *head,
> >                                     uint8_t *data, RDMAControlHeader *r=
esp,
> >                                     int *resp_idx,
> > -                                   int (*callback)(RDMAContext *rdma))=
;
> > +                                   int (*callback)(RDMAContext *rdma,
> > +                                   uint8_t id),
> > +                                   uint8_t id);
> > =20
> >  static inline uint64_t ram_chunk_index(const uint8_t *start,
> >                                         const uint8_t *host) @@=20
> > -1198,24 +1200,81 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
> >      return 0;
> >  }
> > =20
> > -static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma)
> > +/*
> > + * Parameters:
> > + *    @id =3D=3D UNUSED_ID :
> > + *    This means that we register memory for the main RDMA channel,
> > + *    the main RDMA channel don't register the mach-virt.ram block
> > + *    when we use multiRDMA method to migrate.
> > + *
> > + *    @id =3D=3D 0 or id =3D=3D 1 or ... :
> > + *    This means that we register memory for the multiRDMA channels,
> > + *    the multiRDMA channels only register memory for the mach-virt.ra=
m
> > + *    block when we use multiRDAM method to migrate.
> > + */
> > +static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma, uint8_t=
=20
> > +id)
> >  {
> >      int i;
> >      RDMALocalBlocks *local =3D &rdma->local_ram_blocks;
> > =20
> > -    for (i =3D 0; i < local->nb_blocks; i++) {
> > -        local->block[i].mr =3D
> > -            ibv_reg_mr(rdma->pd,
> > -                    local->block[i].local_host_addr,
> > -                    local->block[i].length,
> > -                    IBV_ACCESS_LOCAL_WRITE |
> > -                    IBV_ACCESS_REMOTE_WRITE
> > -                    );
> > -        if (!local->block[i].mr) {
> > -            perror("Failed to register local dest ram block!\n");
> > -            break;
> > +    if (migrate_use_multiRDMA()) {
> > +        if (id =3D=3D UNUSED_ID) {
> > +            for (i =3D 0; i < local->nb_blocks; i++) {
> > +                /* main RDMA channel don't register the mach-virt.ram =
block */
> > +                if (strcmp(local->block[i].block_name, "mach-virt.ram"=
) =3D=3D 0) {
> > +                    continue;
> > +                }
> > +
> > +                local->block[i].mr =3D
> > +                    ibv_reg_mr(rdma->pd,
> > +                            local->block[i].local_host_addr,
> > +                            local->block[i].length,
> > +                            IBV_ACCESS_LOCAL_WRITE |
> > +                            IBV_ACCESS_REMOTE_WRITE
> > +                            );
> > +                if (!local->block[i].mr) {
> > +                    perror("Failed to register local dest ram block!\n=
");
> > +                    break;
> > +                }
> > +                rdma->total_registrations++;
> > +            }
> > +        } else {
> > +            for (i =3D 0; i < local->nb_blocks; i++) {
> > +                /*
> > +                 * The multiRDAM channels only register
> > +                 * the mach-virt.ram block
> > +                 */
> > +                if (strcmp(local->block[i].block_name, "mach-virt.ram"=
) =3D=3D 0) {
> > +                    local->block[i].mr =3D
> > +                        ibv_reg_mr(rdma->pd,
> > +                                local->block[i].local_host_addr,
> > +                                local->block[i].length,
> > +                                IBV_ACCESS_LOCAL_WRITE |
> > +                                IBV_ACCESS_REMOTE_WRITE
> > +                                );
> > +                    if (!local->block[i].mr) {
> > +                        perror("Failed to register local dest ram bloc=
k!\n");
> > +                        break;
> > +                    }
> > +                    rdma->total_registrations++;
> > +                }
> > +            }
> > +        }
> > +    } else {
> > +        for (i =3D 0; i < local->nb_blocks; i++) {
> > +            local->block[i].mr =3D
> > +                ibv_reg_mr(rdma->pd,
> > +                        local->block[i].local_host_addr,
> > +                        local->block[i].length,
> > +                        IBV_ACCESS_LOCAL_WRITE |
> > +                        IBV_ACCESS_REMOTE_WRITE
> > +                        );
> > +            if (!local->block[i].mr) {
> > +                perror("Failed to register local dest ram block!\n");
> > +                break;
> > +            }
> > +            rdma->total_registrations++;
> >          }
> > -        rdma->total_registrations++;
> >      }
> > =20
> >      if (i >=3D local->nb_blocks) {
> > @@ -1223,8 +1282,10 @@ static int qemu_rdma_reg_whole_ram_blocks(RDMACo=
ntext *rdma)
> >      }
> > =20
> >      for (i--; i >=3D 0; i--) {
> > -        ibv_dereg_mr(local->block[i].mr);
> > -        rdma->total_registrations--;
> > +        if (local->block[i].mr) {
> > +            ibv_dereg_mr(local->block[i].mr);
> > +            rdma->total_registrations--;
> > +        }
> >      }
> > =20
> >      return -1;
> > @@ -1446,7 +1507,7 @@ static int qemu_rdma_unregister_waiting(RDMAConte=
xt *rdma)
> >          reg.key.chunk =3D chunk;
> >          register_to_network(rdma, &reg);
> >          ret =3D qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
> > -                                &resp, NULL, NULL);
> > +                                      &resp, NULL, NULL, UNUSED_ID);
> >          if (ret < 0) {
> >              return ret;
> >          }
> > @@ -1915,11 +1976,17 @@ static void qemu_rdma_move_header(RDMAContext *=
rdma, int idx,
> >   * The extra (optional) response is used during registration to us fro=
m having
> >   * to perform an *additional* exchange of message just to provide a re=
sponse by
> >   * instead piggy-backing on the acknowledgement.
> > + *
> > + * Parameters:
> > + *    @id : callback function need two parameters, id is the second pa=
rameter.
> > + *
> >   */
> >  static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeade=
r *head,
> >                                     uint8_t *data, RDMAControlHeader *r=
esp,
> >                                     int *resp_idx,
> > -                                   int (*callback)(RDMAContext *rdma))
> > +                                   int (*callback)(RDMAContext *rdma,
> > +                                   uint8_t id),
> > +                                   uint8_t id)
> >  {
> >      int ret =3D 0;
> > =20
> > @@ -1973,7 +2040,7 @@ static int qemu_rdma_exchange_send(RDMAContext *r=
dma, RDMAControlHeader *head,
> >      if (resp) {
> >          if (callback) {
> >              trace_qemu_rdma_exchange_send_issue_callback();
> > -            ret =3D callback(rdma);
> > +            ret =3D callback(rdma, id);
> >              if (ret < 0) {
> >                  return ret;
> >              }
> > @@ -2168,7 +2235,7 @@ retry:
> > =20
> >                  compress_to_network(rdma, &comp);
> >                  ret =3D qemu_rdma_exchange_send(rdma, &head,
> > -                                (uint8_t *) &comp, NULL, NULL, NULL);
> > +                                (uint8_t *) &comp, NULL, NULL, NULL,=
=20
> > + UNUSED_ID);
> > =20
> >                  if (ret < 0) {
> >                      return -EIO;
> > @@ -2195,7 +2262,7 @@ retry:
> > =20
> >              register_to_network(rdma, &reg);
> >              ret =3D qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &=
reg,
> > -                                    &resp, &reg_result_idx, NULL);
> > +                                    &resp, &reg_result_idx, NULL,=20
> > + UNUSED_ID);
> >              if (ret < 0) {
> >                  return ret;
> >              }
> > @@ -2828,7 +2895,8 @@ static ssize_t qio_channel_rdma_writev(QIOChannel=
 *ioc,
> >              head.len =3D len;
> >              head.type =3D RDMA_CONTROL_QEMU_FILE;
> > =20
> > -            ret =3D qemu_rdma_exchange_send(rdma, &head, data, NULL, N=
ULL, NULL);
> > +            ret =3D qemu_rdma_exchange_send(rdma, &head, data, NULL,
> > +                                          NULL, NULL, UNUSED_ID);
> > =20
> >              if (ret < 0) {
> >                  rdma->error_state =3D ret; @@ -3660,7 +3728,7 @@ stati=
c=20
> > int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
> >              }
> > =20
> >              if (rdma->pin_all) {
> > -                ret =3D qemu_rdma_reg_whole_ram_blocks(rdma);
> > +                ret =3D qemu_rdma_reg_whole_ram_blocks(rdma,=20
> > + UNUSED_ID);
> >                  if (ret) {
> >                      error_report("rdma migration: error dest "
> >                                      "registering ram blocks"); @@=20
> > -3675,6 +3743,15 @@ static int qemu_rdma_registration_handle(QEMUFile *=
f, void *opaque)
> >               * their "local" descriptions with what was sent.
> >               */
> >              for (i =3D 0; i < local->nb_blocks; i++) {
> > +                /*
> > +                 * use the main RDMA channel to deliver the block of d=
evice
> > +                 * use the multiRDMA channels to deliver the RAMBlock
> > +                 */
> > +                if (migrate_use_multiRDMA() &&
> > +                    strcmp(local->block[i].block_name, "mach-virt.ram"=
) =3D=3D 0) {
> > +                        continue;
> > +                }
> > +
> >                  rdma->dest_blocks[i].remote_host_addr =3D
> >                      (uintptr_t)(local->block[i].local_host_addr);
> > =20
> > @@ -3992,7 +4069,7 @@ static int qemu_rdma_registration_stop(QEMUFile *=
f, void *opaque,
> >           */
> >          ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, &resp,
> >                      &reg_result_idx, rdma->pin_all ?
> > -                    qemu_rdma_reg_whole_ram_blocks : NULL);
> > +                    qemu_rdma_reg_whole_ram_blocks : NULL,=20
> > + UNUSED_ID);
> >          if (ret < 0) {
> >              ERROR(errp, "receiving remote info!");
> >              return ret;
> > @@ -4025,6 +4102,11 @@ static int qemu_rdma_registration_stop(QEMUFile =
*f, void *opaque,
> >          memcpy(rdma->dest_blocks,
> >              rdma->wr_data[reg_result_idx].control_curr, resp.len);
> >          for (i =3D 0; i < nb_dest_blocks; i++) {
> > +            if (migrate_use_multiRDMA() &&
> > +                strcmp(local->block[i].block_name, "mach-virt.ram") =
=3D=3D 0) {
> > +                continue;
> > +            }
> > +
> >              network_to_dest_block(&rdma->dest_blocks[i]);
> > =20
> >              /* We require that the blocks are in the same order */ @@=
=20
> > -4050,7 +4132,8 @@ static int qemu_rdma_registration_stop(QEMUFile *f, =
void *opaque,
> >      trace_qemu_rdma_registration_stop(flags);
> > =20
> >      head.type =3D RDMA_CONTROL_REGISTER_FINISHED;
> > -    ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NUL=
L);
> > +    ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL,
> > +                                  NULL, NULL, UNUSED_ID);
> > =20
> >      if (migrate_use_multiRDMA()) {
> >          /*
> > @@ -4298,7 +4381,7 @@ static int qemu_multiRDMA_registration_handle(voi=
d *opaque)
> >                    sizeof(RDMALocalBlock), dest_ram_sort_func);
> > =20
> >              if (rdma->pin_all) {
> > -                ret =3D qemu_rdma_reg_whole_ram_blocks(rdma);
> > +                ret =3D qemu_rdma_reg_whole_ram_blocks(rdma, p->id);
> >                  if (ret) {
> >                      error_report("rdma migration: error dest "
> >                                   "registering ram blocks"); @@=20
> > -4680,7 +4763,7 @@ static void *multiRDMA_send_thread(void *opaque)
> > =20
> >      ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, &resp,
> >              &reg_result_idx, rdma->pin_all ?
> > -            qemu_rdma_reg_whole_ram_blocks : NULL);
> > +            qemu_rdma_reg_whole_ram_blocks : NULL, p->id);
> >      if (ret < 0) {
> >          return NULL;
> >      }
> > @@ -4749,7 +4832,8 @@ static void *multiRDMA_send_thread(void *opaque)
> > =20
> >          /* Send FINISHED to the destination */
> >          head.type =3D RDMA_CONTROL_REGISTER_FINISHED;
> > -        ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL,=
 NULL);
> > +        ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL,
> > +                                      NULL, NULL, p->id);
> >          if (ret < 0) {
> >              return NULL;
> >          }
> > --
> > 2.19.1
> >=20
> >=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


