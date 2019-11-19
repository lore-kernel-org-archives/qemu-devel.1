Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9117C43215
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADD032231A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SmAhQpJN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADD032231A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48655 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX7fY-00064I-4U
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:52:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53234)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iX7eZ-0005QP-4E
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iX7eV-00050d-Sw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:51:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56116
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iX7eV-0004zx-I2
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574185857;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iO25zAir3pb37M4tqQZWSaxbeYzYMskWLEXU8sSC4j4=;
 b=SmAhQpJNpHrDVE+MqKi/q6XfcBVWm/gSLaz3vQPOpdQRQHuBeGlhWXho8UoWfWzjFKl5+f
 UufGiw6k6iv+w41HdZxF+oMvaIy8g3wFn7olq3JEPFWX0oHwBrTggFQelI9B1l4RUmp8VE
 N2IVBpgTtBXXrHJokpsdjlcm1dZthJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-KSVYjEpnOtKHAR3Om2rX6Q-1; Tue, 19 Nov 2019 12:50:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 61F6E801E59;
 Tue, 19 Nov 2019 17:50:54 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B0C0C18214;
 Tue, 19 Nov 2019 17:50:47 +0000 (UTC)
Date: Tue, 19 Nov 2019 17:50:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH 2/6] iotests: Skip test 079 if it is not possible to
 create large files
Message-ID: <20191119175044.GH2706053@redhat.com>
References: <20191119170822.45649-1-thuth@redhat.com>
 <20191119170822.45649-3-thuth@redhat.com>
 <7242d268-6563-246f-4acc-2e714ebfd513@redhat.com>
 <06a31aff-e01b-74ae-3d9a-ff0f8ea2696b@redhat.com>
 <1d32c8c3-1cc3-574d-e79f-4b5bc2f376d3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1d32c8c3-1cc3-574d-e79f-4b5bc2f376d3@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: KSVYjEpnOtKHAR3Om2rX6Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 19, 2019 at 06:38:20PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 11/19/19 6:34 PM, Thomas Huth wrote:
> > On 19/11/2019 18.29, Philippe Mathieu-Daud=C3=A9 wrote:
> > > On 11/19/19 6:08 PM, Thomas Huth wrote:
> > > > Test 079 fails in the arm64, s390x and ppc64le LXD containers, whic=
h
> > > > apparently do not allow large files to be created. Test 079 tries t=
o
> > > > create a 4G sparse file, so check first whether we can really creat=
e
> > > > such files before executing the test.
> > > >=20
> > > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > > ---
> > > >  =C2=A0 tests/qemu-iotests/079 | 6 ++++++
> > > >  =C2=A0 1 file changed, 6 insertions(+)
> > > >=20
> > > > diff --git a/tests/qemu-iotests/079 b/tests/qemu-iotests/079
> > > > index 81f0c21f53..e9b81419b7 100755
> > > > --- a/tests/qemu-iotests/079
> > > > +++ b/tests/qemu-iotests/079
> > > > @@ -39,6 +39,12 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> > > >  =C2=A0 _supported_fmt qcow2
> > > >  =C2=A0 _supported_proto file nfs
> > > >  =C2=A0 +# Some containers (e.g. non-x86 on Travis) do not allow la=
rge files
> > > > +if ! truncate --size=3D4G "$TEST_IMG"; then
> > >=20
> > > Shouldn't we restrict that to Travis-CI by checking some environment =
var?
> >=20
> > I'd rather like to keep it independent from Travis environment
> > variables, since somebody might want to run "make check" in other
> > non-Travis containers or on weird filesystems, and then the test should
> > ideally not fail, but simply skip, too.
>=20
> I see. But it would be bad if we stop catching normal bugs with this test
> because we restricted it to contained environments.
>=20
> Maybe we can add a generic is_contained() routine that only checks for
> TRAVIS env var, and people using other containers can expand it.

"is_contained" is still expressing the environment.

What we need is a way to express features, and be able to switch beteen
autodetecting features & mandatory enablement.

eg

   if has_feature "large_file"
   then
       ...stuff using large files...
   fi

The "has_feature" helper would by default call out to
"has_feature_large_file" todo automatic probing so that things
"just work" according to whatever env the tests are run inside.

There should, however, be a flag to "./check" which force enables
the feature eg  "./check --require-feature large_file" will force
execution and not attempt to probe for it.

We could have "--require-feature :all" to force enable all optional
bits.

Any formal CI systems should use --require-feature to explicitly
force testing of features that are expected to always work.

so Travis x86 would use "--require-feature large_large", but
the arch64 version would not pass this flag and so do probing
which will auto-skip.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


