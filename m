Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904EEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:55:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8C3206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 19:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TK0UTLuy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8C3206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jikKs-0004Td-Jc
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 15:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jikK4-0003j2-Kv
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 15:54:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30008
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1jikK3-0002UM-DX
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 15:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591732449;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gcKu+E8nWMN6SmKNUbIntXwxTv0kkJ0jZL2SWFL1pU=;
 b=TK0UTLuyPWYNkcvVGA396Ert4dSQh52DIXEsn+uAPDZoNMiCN/BqVH4gnCmsL3s1gmQzq9
 b4VjxdtNtgiBMXokDKKP3LH38iFcRxngQfOk8KrqvyWqxzhZksmcM6T1bP3pU8Vv1eFgoB
 F2OxoKWShC7vBwsEZSWaCWyTMBctDfk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-3t0rdmhgMaqCoir46hgh_Q-1; Tue, 09 Jun 2020 15:54:06 -0400
X-MC-Unique: 3t0rdmhgMaqCoir46hgh_Q-1
Received: by mail-wr1-f71.google.com with SMTP id l1so2589wrc.8
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 12:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=+BJRkonEJx+ZVdwFs6Fv9GhnTl9qmo3SNY2XjYXe1xc=;
 b=uCOeedgCx4Bxdfvx2AdyRWYa3aBjwXVd1y1URcyIFLdUbRRhLamAoXHKhLlsV1Nmx3
 FKNVEMd6h89csRsQ3mFs4tYpmdPlGMZ1oDqxUqb6nnE8KrlP8zyn5ni8OqXVx1+Ukgn1
 1hIYnBG+JJuWtGbUOffCWtLHpZt0IsL9YaGa2mYPmPf1K6TnqOL7Yc2VVCMpHW2mt1Wv
 CmfKUneLtc7FsgCgjNzq4i/S9E4IA+OHWSS5W4IeiFOvKEyVNeXAYW2Pf3Re9IYapGxl
 K7GYSENOtoNVeaZk18T/Prjwvi1lg/GBh3Q9BzhOSi4Jzjf9NsSTCcLO1i8UX5ey9M18
 Kw8g==
X-Gm-Message-State: AOAM532EXfW+nxeec3F0b22xKvtO7uTAWjcNJ/Xby2L8eEzXrtVv+Xy8
 /bLREZP7m/Z62WhCmjT5TETmtXxKJvZhNo/wD2yESSQxnHvuvJgN4YWIMms98tf0F0qP8SfFJZ+
 v6iLrYse+fh/F1Sk=
X-Received: by 2002:adf:f446:: with SMTP id f6mr6240933wrp.59.1591732445572;
 Tue, 09 Jun 2020 12:54:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVSAhS9By6hEKC4dTsLyv6qAh0Rl9AA+1K1hr9Ygb1hRBqUIEmv23+WTfqP/I3WqlpyXB04g==
X-Received: by 2002:adf:f446:: with SMTP id f6mr6240888wrp.59.1591732445210;
 Tue, 09 Jun 2020 12:54:05 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6339.dip0.t-ipconnect.de. [91.12.99.57])
 by smtp.gmail.com with ESMTPSA id
 a1sm4147281wmd.28.2020.06.09.12.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 12:54:04 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 00/20] virtio-mem: Paravirtualized memory hot(un)plug
Date: Tue, 9 Jun 2020 21:54:02 +0200
Message-Id: <9083E2B4-88E4-4E0E-9270-225F1B2DF046@redhat.com>
References: <20200609194114.GA15818@linux.intel.com>
In-Reply-To: <20200609194114.GA15818@linux.intel.com>
To: Sean Christopherson <sean.j.christopherson@intel.com>
X-Mailer: iPhone Mail (17E262)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=david@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:44:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 teawater <teawaterz@linux.alibaba.com>, Janosch Frank <frankja@linux.ibm.com>,
 Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Richard Henderson <rth@twiddle.net>, Eric Farman <farman@linux.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> Am 09.06.2020 um 21:42 schrieb Sean Christopherson <sean.j.christopherson=
@intel.com>:
>=20
> =EF=BB=BFOn Tue, Jun 09, 2020 at 02:42:59PM -0400, Michael S. Tsirkin wro=
te:
>>> On Tue, Jun 09, 2020 at 08:38:15PM +0200, David Hildenbrand wrote:
>>> On 09.06.20 18:18, Eduardo Habkost wrote:
>>>> On Tue, Jun 09, 2020 at 11:59:04AM -0400, Michael S. Tsirkin wrote:
>>>>> On Tue, Jun 09, 2020 at 03:26:08PM +0200, David Hildenbrand wrote:
>>>>>> On 09.06.20 15:11, Michael S. Tsirkin wrote:
>>>>>>> On Wed, Jun 03, 2020 at 04:48:54PM +0200, David Hildenbrand wrote:
>>>>>>>> This is the very basic, initial version of virtio-mem. More info o=
n
>>>>>>>> virtio-mem in general can be found in the Linux kernel driver v2 p=
osting
>>>>>>>> [1] and in patch #10. The latest Linux driver v4 can be found at [=
2].
>>>>>>>>=20
>>>>>>>> This series is based on [3]:
>>>>>>>>    "[PATCH v1] pc: Support coldplugging of virtio-pmem-pci devices=
 on all
>>>>>>>>     buses"
>>>>>>>>=20
>>>>>>>> The patches can be found at:
>>>>>>>>    https://github.com/davidhildenbrand/qemu.git virtio-mem-v3
>>>>>>>=20
>>>>>>> So given we tweaked the config space a bit, this needs a respin.
>>>>>>=20
>>>>>> Yeah, the virtio-mem-v4 branch already contains a fixed-up version. =
Will
>>>>>> send during the next days.
>>>>>=20
>>>>> BTW. People don't normally capitalize the letter after ":".
>>>>> So a better subject is
>>>>>  virtio-mem: paravirtualized memory hot(un)plug
>>>>=20
>>>> I'm not sure that's still the rule:
>>>>=20
>>>> [qemu/(49ee115552...)]$ git log --oneline v4.0.0.. | egrep ': [A-Z]' |=
 wc -l
>>>> 5261
>>>> [qemu/(49ee115552...)]$ git log --oneline v4.0.0.. | egrep ': [a-z]' |=
 wc -l
>>>> 2921
>>>>=20
>>>=20
>>> Yeah, I switched to this scheme some years ago (I even remember that
>>> some QEMU maintainer recommended it). I decided to just always
>>> capitalize. Not that it should really matter ... :)
>>=20
>> Don't mind about qemu but you don't want to do that for Linux.
>=20
> Heh, depends on who you ask.  The tip tree maintainers (strongly) prefer
> capitalizing the first word after the colon[*], and that naturally
> percolates into a lot of other subsystems, e.g. I follow that pattern for
> KVM so that I don't have to remember to switch when submitting patches
> against a tip branch.
>=20

Dito, most developers have other things to worry about. E.g., Andrew (-mm t=
ree) automatically converts everything to lower-case when applying patches.


