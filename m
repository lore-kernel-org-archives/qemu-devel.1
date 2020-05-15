Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A17C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:52:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6C97206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 05:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvH+U1Fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C97206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTGh-0002WE-4V
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 01:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTFw-000264-6b
 for qemu-devel@nongnu.org; Fri, 15 May 2020 01:51:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41737
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTFv-00018x-7W
 for qemu-devel@nongnu.org; Fri, 15 May 2020 01:51:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589521893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KJHkep882nVm/fMc3tVrfFGKPKxCvkmaoBJLNwE69IM=;
 b=NvH+U1FrpfRbQD/D8kPTvsZaHZ1Gj6s3DQfXo57tCZVvo2dwRy0IyhLFme/1mxGiz6+K6b
 qy8Mc+G6+G0sU/CJIRRU1oPECTThG6Y5YMfgj+eRzQG6scEtE8m+j4yQ88t5WnJqyNEBFd
 X/eDRl9CU8VrrhkyZfWe17DEpBe+sUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-Y-ieLkVmNtWyeQxCHz_M8g-1; Fri, 15 May 2020 01:51:30 -0400
X-MC-Unique: Y-ieLkVmNtWyeQxCHz_M8g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00B1980183C;
 Fri, 15 May 2020 05:51:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1ED260C05;
 Fri, 15 May 2020 05:51:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 528BB11358BC; Fri, 15 May 2020 07:51:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: proposal: deprecate -readconfig/-writeconfig
References: <7599153e-89a2-9a86-16ad-4a3c6a107b18@redhat.com>
 <20200514085622.GB1280939@redhat.com>
 <56379563-c1f3-3270-f9ac-5bdd49b324aa@redhat.com>
 <20200514153456.GL1280939@redhat.com>
Date: Fri, 15 May 2020 07:51:27 +0200
In-Reply-To: <20200514153456.GL1280939@redhat.com> ("Daniel P. =?utf-8?Q?B?=
 =?utf-8?Q?errang=C3=A9=22's?=
 message of "Thu, 14 May 2020 16:34:56 +0100")
Message-ID: <87blmpsq3k.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 23:27:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, May 14, 2020 at 10:40:40AM -0400, John Snow wrote:
>>=20
>>=20
>> On 5/14/20 4:56 AM, Daniel P. Berrang=C3=A9 wrote:
>> > On Thu, May 14, 2020 at 10:09:21AM +0200, Paolo Bonzini wrote:
>> >> IMHO configuration files are in general a failed experiment.  In
>> >> practice, they do not add much value over just a shell script because
>> >> they don't allow configuring all QEMU options, they are very much fix=
ed
>> >> (by their nature).  I think it's more or less agreed that they are no=
t
>> >> solving any problem for higher-level management stacks as well; those
>> >> would prefer to configure the VM via QMP or another API.
>> >>
>> >> So, any objections to deprecating -readconfig and -writeconfig?
>> >=20
>> > Libvirt would like to have a config file for QEMU, but it would have
>> > to be one that actually covers all the config options QEMU supports,
>> > and ideally using a data format in common with that used for runtime
>> > changes. So for libvirt's needs the current readconfig is entirely
>> > useless.
>> >=20
>>=20
>> Yeah. In this sense, would a json/yaml config file help, under the
>> premise that you could just cat it into the pipe to configure a machine?
>>=20
>> (Assuming we had proper runtime configuration commands, of course.)
>
> Yeah, the key thing is that you really want to be able to provide the
> whole initial config in one go as an atomic action. I don't want to
> issue 100 individual QMP commands to load each initial device. With
> that in mind it doesn't really matter whether you do
>
>   $ qemu -qmp stdio
>   (qmp) load-config /some/file.yaml
>
> vs
>
>   $ qemu -qmp stdio -load-config /some/file.yaml
>
> though the latter is probably slightly nicer as it lets you grep
> for the VM based on the filename visible in the CLI.=20

Once QEMU can do the former, providing the latter should be trivial.
Not providing it would be unadvisable.

Yes, a management application that talks QMP anyway can be expected to
be quite happy with having to do initial configuration via QMP, with or
without a load-config command.

But human users won't be happy.  Having to use a wrapper program to feed
their configuration file to QMP adds undue complexity.

[...]


