Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59385C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24ADE214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 16:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5x8YZ6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24ADE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if5Ky-0000HA-8v
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 11:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1if5K8-0008FH-Uq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:58:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1if5K5-0001ZY-Bn
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:58:50 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33441
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1if5K4-0001X8-UH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 11:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576083527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FbmRB3fcXOchRvjr5xZoMVU+BWtOFp64v3teU6Vo040=;
 b=B5x8YZ6x7/n4rzDPKZWTt5EcmaWHsSwl6BWUSpInV5QV0z4Fk46mr1XPuAeYKRSKlGWJbO
 ALkTkeGCHZ+UI0fsc3Qtyg/w6pvCTrxbWB4E+Znnw4siiV0JkMhOOanSIFscvbeN79iqDK
 PYrME1zvgfax567V32z3g+fm7/8NUP0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-Z3lT-cdMPfOjzrnsPtE3XQ-1; Wed, 11 Dec 2019 11:58:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45E90107ACC9;
 Wed, 11 Dec 2019 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-129.rdu2.redhat.com
 [10.10.122.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC9685DA70;
 Wed, 11 Dec 2019 16:58:36 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] python/qemu: accel: Add list_accel() method
To: Cleber Rosa <crosa@redhat.com>
References: <20191206213433.11305-1-wainersm@redhat.com>
 <20191206213433.11305-3-wainersm@redhat.com>
 <20191210005258.GC31990@localhost.localdomain>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <fee77377-2ffc-af79-4740-23682096f799@redhat.com>
Date: Wed, 11 Dec 2019 14:58:35 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191210005258.GC31990@localhost.localdomain>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Z3lT-cdMPfOjzrnsPtE3XQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: fam@euphon.net, ehabkost@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, philmd@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 12/9/19 10:52 PM, Cleber Rosa wrote:
> On Fri, Dec 06, 2019 at 04:34:31PM -0500, Wainer dos Santos Moschetta wro=
te:
>> Since commit cbe6d6365a48 the command `qemu -accel help` returns
>> the list of accelerators enabled in the QEMU binary. This adds
>> the list_accel() method which return that same list.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>> ---
>>   python/qemu/accel.py | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
>>
>> diff --git a/python/qemu/accel.py b/python/qemu/accel.py
>> index cbeac10dd1..746b7e68f5 100644
>> --- a/python/qemu/accel.py
>> +++ b/python/qemu/accel.py
>> @@ -14,7 +14,11 @@ accelerators.
>>   # the COPYING file in the top-level directory.
>>   #
>>  =20
>> +import logging
>>   import os
>> +import subprocess
>> +
>> +LOG =3D logging.getLogger(__name__)
>>  =20
>>   # Mapping host architecture to any additional architectures it can
>>   # support which often includes its 32 bit cousin.
>> @@ -23,6 +27,25 @@ ADDITIONAL_ARCHES =3D {
>>       "aarch64" : "armhf"
>>   }
>>  =20
>> +def list_accel(qemu_bin):
>> +    """
>> +    List accelerators enabled in the QEMU binary.
>> +
>> +    @param qemu_bin (str): path to the QEMU binary.
>> +    @raise Exception: if failed to run `qemu -accel help`
>> +    @return a list of accelerator names.
>> +    """
>> +    if not qemu_bin:
>> +        return []
>> +    try:
>> +        out =3D subprocess.check_output("%s -accel help" % qemu_bin, sh=
ell=3DTrue)
> There's no need to use a shell here.  This could become:
>
>     out =3D subprocess.check_output([qemu_bin, '-accel' 'help'])

Ack

>
>> +    except:
>> +        LOG.debug("Failed to get the list of accelerators in %s" % qemu=
_bin)
>> +        raise
>> +    lines =3D out.decode().splitlines()
> And maybe discard the first line earlier with:
>
>     lines =3D out.decode().splitlines()[1:]
>
> Also, you could avoid the manual decode() with the `universal_newlines`
> option to subprocess.check_output(), ie:
>
>     accels =3D subprocess.check_output([qemu-bin, '-accel', 'help'],
>                                      universal_newlines=3DTrue).splitline=
s()[1:]

Nice. v3 will have universal_newlines=3DTrue.

>
>> +    # Skip the first line which is the header.
>> +    return [l.strip() for l in lines[1:] if l]
>> +
> I think that the `if l` check can actually hide undesirable behavior
> (bugs) in the `qemu -accel ?` output.  I don't remember seeing
> `-$(option) ?` returning empty strings but doesn't mean it couldn't
> and shouldn't).
>
> I do remember `-machine ?` returning random non-printable characters
> that turned out to be a bug, though.

Double-checking: are you suggesting to remove the 'if not empty' check=20
so that bugs on output could emerge?

Thanks!

- Wainer

>
>>   def kvm_available(target_arch=3DNone):
>>       host_arch =3D os.uname()[4]
>>       if target_arch and target_arch !=3D host_arch:
>> --=20
>> 2.21.0
>>
> - Cleber.


