Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E514DC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B32E32075A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 18:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VA8kOIID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B32E32075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3Ku-0007bl-Pz
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 14:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jS3K8-0006ry-Tb
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:45:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1jS3K7-0004Eh-Tv
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:45:16 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49391
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1jS3K7-00045W-FB
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 14:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587753913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fz5PIiFGXm9Y7ccYzfzVflDME/XrW2TMoJ1cAN5Pe4U=;
 b=VA8kOIID+uPRpG4CS44Cggs9Ql7wv1vdQyT8TPOBbA04hcuUQ3cxvX/sB72BQvZD2FZADs
 5JhQujCjzeUde8zeURzCzco8ViNBaWtn4lHR3rYsCBaO3S4krq8JMBohC6Xx/r1QrPke8y
 3mAN6w3nwXzrcn7ZNHCBDY5YK3pRKCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-d-7cM-5_NkCAT2ueq1wlMw-1; Fri, 24 Apr 2020 14:45:02 -0400
X-MC-Unique: d-7cM-5_NkCAT2ueq1wlMw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E6FC107B274;
 Fri, 24 Apr 2020 18:45:01 +0000 (UTC)
Received: from localhost (ovpn-115-107.phx2.redhat.com [10.3.115.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BEB3D605CF;
 Fri, 24 Apr 2020 18:44:53 +0000 (UTC)
Date: Fri, 24 Apr 2020 14:44:48 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Add a new PIIX option to control PCI hot unplugging of
 devices on non-root buses
Message-ID: <20200424184448.GS4952@habkost.net>
References: <1587136411-200885-1-git-send-email-ani.sinha@nutanix.com>
 <20200417112620-mutt-send-email-mst@kernel.org>
 <2A13ACCD-BD24-41FB-B6EA-2804F7C1FF1D@nutanix.com>
 <20200417120732-mutt-send-email-mst@kernel.org>
 <20200420092459.GF346737@redhat.com>
 <20200420105936-mutt-send-email-mst@kernel.org>
 <07BC06B8-34F6-4C46-ACCE-DD7A4CBA9BC7@nutanix.com>
 <20200421150201.GI479771@redhat.com>
 <A31A7DC2-E1FB-409B-9A99-324F8879E9AD@nutanix.com>
 <819DA747-F897-44A4-A238-B6F20C4C8B08@nutanix.com>
MIME-Version: 1.0
In-Reply-To: <819DA747-F897-44A4-A238-B6F20C4C8B08@nutanix.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:45:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Ani Sinha <ani.sinha@nutanix.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Apr 24, 2020 at 03:23:56PM +0000, Ani Sinha wrote:
>=20
>=20
> > On Apr 22, 2020, at 4:15 PM, Ani Sinha <ani.sinha@nutanix.com> wrote:
> >=20
> >=20
> >=20
> >> On Apr 21, 2020, at 8:32 PM, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >>=20
> >> On Tue, Apr 21, 2020 at 02:45:04PM +0000, Ani Sinha wrote:
> >>>=20
> >>>=20
> >>>> On Apr 20, 2020, at 8:32 PM, Michael S. Tsirkin <mst@redhat.com> wro=
te:
> >>>>=20
> >>>> But I for one would like to focus on keeping PIIX stable
> >>>> and focus development on q35.  Not bloating PIIX with lots of new
> >>>> features is IMHO a good way to do that.
> >>>=20
> >>> Does this mean this patch is a no-go then? :(
> >>=20
> >> I'd support this patch, as I don't think it can really be described as
> >> bloat or destabalizing. It is just adding a simple property to
> >> conditionalize existing functionality.  Telling people to switch to Q3=
5
> >> is unreasonable as it is not a simple 1-1 conversion from existing use
> >> of PIIX. Q35 has much higher complexity in its configuration, has high=
er
> >> memory overhead per VM too, and lacks certain features of PIIX too.
> >=20
> > Cool. How do we go forward from here?
> >=20
>=20
> We would really appreciate if we can add this extra knob in
> Qemu. Maybe someone else also in the community will find this
> useful. We don=E2=80=99t want to maintain this patch internally forever
> but rather prefer we maintain this as a Qemu community.

Michael, I agree with Daniel here and I don't think we should
start refusing PIIX features if they are useful for a portion of
the QEMU community.

Would you reconsider and merge this patch?

--=20
Eduardo


