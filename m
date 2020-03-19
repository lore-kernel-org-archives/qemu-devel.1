Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C278C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:59:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E3A2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 17:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AeVTAqNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E3A2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEzSQ-0001Dn-1Y
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 13:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40981)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1jEzRb-0000lL-9y
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1jEzRa-000815-2B
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:58:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:60927)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1jEzRZ-0007zV-Ua
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 13:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584640737;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ttjd02UuqlmcqFt8C88E+IiGbJtota4iold6BuQL+Ik=;
 b=AeVTAqNbVTOFl0UYiI86IcHdrr/w3zYINMPpkcNN+ayNpsVG0qpYuNNv7K5V7da40vBDl/
 A0Ck2IVOKkfOWm7/yHXFBbNosrrCJSUt119oOJmarxI3MdBsWK0G0K+/MxsBO9LMtG1WMf
 KLAV6OGIRIjf+gcZWwTLSrg1UcE3/cM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-Ln9yMNrLO4mUrBQOQI3U0w-1; Thu, 19 Mar 2020 13:58:54 -0400
X-MC-Unique: Ln9yMNrLO4mUrBQOQI3U0w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A426E107ACC9;
 Thu, 19 Mar 2020 17:58:53 +0000 (UTC)
Received: from redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E2E919C58;
 Thu, 19 Mar 2020 17:58:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v5 7/7] virtio-net: add migration support for RSS and hash
 report
In-Reply-To: <CAOEp5Odhjr6h7erYz_VchjRF98-SNt27RW_T_ao7P0nwc-0ebg@mail.gmail.com>
 (Yuri Benditovich's message of "Thu, 19 Mar 2020 19:19:26 +0200")
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
 <20200318091525.27044-8-yuri.benditovich@daynix.com>
 <20200318104826.GF2850@work-vm>
 <CAOEp5Odhjr6h7erYz_VchjRF98-SNt27RW_T_ao7P0nwc-0ebg@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 19 Mar 2020 18:58:46 +0100
Message-ID: <87y2rwdy5l.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Reply-To: quintela@redhat.com
Cc: Yan Vugenfirer <yan@daynix.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi Yuri

Yuri Benditovich <yuri.benditovich@daynix.com> wrote:
> On Wed, Mar 18, 2020 at 12:48 PM Dr. David Alan Gilbert <dgilbert@redhat.=
com>
> wrote:
>
>  * Yuri Benditovich (yuri.benditovich@daynix.com) wrote:
>  > Save and restore RSS/hash report configuration.
>  >=20
>  > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>  > ---
>  >  hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++
>  >  1 file changed, 26 insertions(+)
>  >=20
>  > diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
>  > index a0614ad4e6..0b058aae9f 100644
>  > --- a/hw/net/virtio-net.c
>  > +++ b/hw/net/virtio-net.c
>  > @@ -2842,6 +2842,13 @@ static int virtio_net_post_load_device(void
>  *opaque, int version_id)
>  >          }
>  >      }
>  > =20
>  > +    if (n->rss_data.enabled) {
>  > +        trace_virtio_net_rss_enable(n->rss_data.hash_types,
>  > +                                    n->rss_data.indirections_len,
>  > +                                    sizeof(n->rss_data.key));
>  > +    } else {
>  > +        trace_virtio_net_rss_disable();
>  > +    }

This is the bigger "abuser" that I have ever seen for a post_load
function.  Just to add a trace depending on a value O:-)

>  >      return 0;
>  >  }
>  > =20
>  > @@ -3019,6 +3026,24 @@ static const VMStateDescription
>  vmstate_virtio_net_has_vnet =3D {
>  >      },
>  >  };
>  > =20
>  > +static const VMStateDescription vmstate_rss =3D {
>  > +    .name      =3D "vmstate_rss",
>
>  You need to do something to avoid breaking migration compatibility
>  from/to old QEMU's and from/to QEMU's on hosts without the new virtio
>  features.
>  Probably adding a .needed =3D   here pointing to a function that
>  checks 'enabled' might do it.
>
> Does VMSTATE_STRUCT_TEST(..,..,checker_procedure,...) result the same thi=
ng?

It is just a similar thing, not the same.
If you add a new field, you need to increase the version number.  And
that make backward compatibility really annoying.
With subsections, you can make it work correctly with old versions
always that you don't use rss.

> Another question about migration support:
> What is expected/required behavior?
> Possible cases:
> old qemu -> new qemu

That should always work.
If you use an optional subsection this works for free.  Old qemu has no
rss subsection.

> new qemu (new feature off) -> old qemu

This is desirable.  And with the optional subsection it just works, no
chang eneeded.

> new qemu (new feature on) -> old qemu

This obviosly will not work, and we are fine.  There will appear a new
subsection that old qemu don't undertand.  Destination will give one
error and give up.

For one example, just look at something like:

hw/virtio/virtio.c:: vmstate_virtio

There are lots of subscitnsios there.

Later, Juan.


