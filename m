Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C21BC47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15ED7206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 14:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeO9vigr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15ED7206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVyVI-00030B-5o
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 10:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVyUR-0001gc-9i
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:24:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25864
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVyUO-0001Wf-SN
 for qemu-devel@nongnu.org; Tue, 05 May 2020 10:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588688642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=swRalGKxU2lSdgcOHXUj6WaWa7nYBd6sW+blqU9Gjq8=;
 b=LeO9vigrtZuaX8AQz5hIURJOMdNOmeQjhKbsCcyC2kEADjgMSzeawkBxCt3ka8dvhTEX9w
 CJdzrVaQxJqLFD/6aksTYiER3nRgK0Sw/INluSNqac/RZYyUSJ4x6zIo/GaY/1Ms3jqik7
 DbhNWxWHsGFMH0Ipn9tvuEdgkHGBx8Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-mJwoh1yxO5mkL8BXfGTRBg-1; Tue, 05 May 2020 10:24:01 -0400
X-MC-Unique: mJwoh1yxO5mkL8BXfGTRBg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F2B4800687;
 Tue,  5 May 2020 14:23:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2540060629;
 Tue,  5 May 2020 14:23:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A95B311358BC; Tue,  5 May 2020 16:23:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 08/17] s390x/cpumodel: Fix UI to CPU features
 pcc-cmac-{aes, eaes}-256
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-9-armbru@redhat.com>
 <7ed42e2f-e437-3d06-e46b-5416e4d2a6d3@redhat.com>
 <874kt0bzq8.fsf@dusky.pond.sub.org>
 <83638290-f00e-7d50-225b-efee0179ff9c@redhat.com>
 <87368i6eed.fsf@dusky.pond.sub.org>
 <68f9c124-aeea-4369-52bf-3f4c7f579a64@redhat.com>
Date: Tue, 05 May 2020 16:23:53 +0200
In-Reply-To: <68f9c124-aeea-4369-52bf-3f4c7f579a64@redhat.com> (David
 Hildenbrand's message of "Sat, 2 May 2020 10:39:14 +0200")
Message-ID: <87mu6ma29y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: berrange@redhat.com, ehabkost@redhat.com, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 pbonzini@redhat.com, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

David Hildenbrand <david@redhat.com> writes:

> On 02.05.20 08:26, Markus Armbruster wrote:
>> David Hildenbrand <david@redhat.com> writes:
>>=20
>>> On 30.04.20 20:22, Markus Armbruster wrote:
>>>> David Hildenbrand <david@redhat.com> writes:
>>>>
>>>>> On 28.04.20 18:34, Markus Armbruster wrote:
>>>>>> Both s390_features[S390_FEAT_PCC_CMAC_AES_256].name and
>>>>>> s390_features[S390_FEAT_PCC_CMAC_EAES_256].name is
>>>>>> "pcc-cmac-eaes-256".  The former is obviously a pasto.
>>>>>>
>>>>>> Impact:
>>>>>>
>>>>>> * s390_feat_bitmap_to_ascii() misidentifies S390_FEAT_PCC_CMAC_AES_2=
56
>>>>>>   as "pcc-cmac-eaes-256".  Affects QMP commands query-cpu-definition=
s,
>>>>>>   query-cpu-model-expansion, query-cpu-model-baseline,
>>>>>>   query-cpu-model-comparison, and the error message when
>>>>>>   s390_realize_cpu_model() fails in check_compatibility().
>>>>>>
>>>>>> * s390_realize_cpu_model() misidentifies it in check_consistency()
>>>>>>   warnings.

Actually not, because the feature isn't in check_consistency()'s dep[].
I'll drop this item.

>>>>>> * s390_cpu_list() likewise.  Affects -cpu help.
>>>>>>
>>>>>> * s390_cpu_model_register_props() creates CPU property
>>>>>>   "pcc-cmac-eaes-256" twice.  The second one fails, but the error is
>>>>>>   ignored (a later commit will change that).  Results in a single
>>>>>>   property "pcc-cmac-eaes-256" with the description for
>>>>>>   S390_FEAT_PCC_CMAC_AES_256, and no property for
>>>>>>   S390_FEAT_PCC_CMAC_EAES_256.  CPU properties are visible in CLI -c=
pu
>>>>>>   and -device, QMP & HMP device_add, QMP device-list-properties, and
>>>>>>   QOM introspection.
>>>>>>
>>>>>> Fix by deleting the wayward 'e'.
>>>>>
>>>>> Very nice catch - thanks!
>>>>
>>>> :)
>>>>
>>>>> While this sounds very bad, it's luckily not that bad in practice
>>>>> (currently).
>>>>>
>>>>> The feature (or rather, both features) is part of the feature group
>>>>> "msa4". As long as we have all sub-features part of that group (which=
 is
>>>>> usually the case), we will always indicate "msa4" to the user, instea=
d
>>>>> of all the separate sub-features. So, expansion, baseline, comparison
>>>>> will usually only work with "msa4".
>>>>>
>>>>> (in addition, current KVM is not capable of actually masking off thes=
e
>>>>> sub-features, so it will still, always see the feature, even if not
>>>>> explicitly specified via "-cpu X,pcc-cmac-aes-256=3Don)
>>>>
>>>> Would you like to propose an commit message improvements?
>>>
>>> Maybe something like
>>>
>>> "Both affected features are part of the feature group msa4. In current
>>> setups, we will always see the msa4 feature instead of the separate
>>> contained sub-features (because all sub-features are around). Therefore=
,
>>> both features are currently never passed from/to the user explicitly
>>> (e.g., via cpu model expansion, comparison, baseline and '-cpu' setup).=
"
>>>
>>> Thanks!
>>=20
>> I think I can guess how this could work for reporting features (I
>> haven't checked my guess against the code), which is what the
>> query-cpu-model-* do: suppress individual features when their group is
>> complete.
>
> Yes. Expand the group to single features on user input, expand the
> single features to the group on user output (if all features are enabled)=
.

Okay, let's play.

Here's query-cpu-definitions:

    $ echo -e '{"execute": "qmp_capabilities"}\n{"execute": "query-cpu-defi=
nitions"}\n{"execute": "quit"}' | ../qemu/bld/s390x-softmmu/qemu-system-s39=
0x -qmp-pretty stdio -S -display none | egrep 'msa4|pcc-cmac-e?aes-256'

Before this patch:

         28                 "pcc-cmac-eaes-256",

After:

         14                 "pcc-cmac-aes-256",
         14                 "pcc-cmac-eaes-256",

No msa4.

Here's query-cpu-model-expansion for model "qemu" (arbitrarily chosen),
type "static":

    $ echo -e '{"execute": "qmp_capabilities"}\n{"execute": "query-cpu-mode=
l-expansion", "arguments": {"type": "full", "model": {"name": "qemu"}}}\n{"=
execute": "quit"}' | $i -qmp-pretty stdio -S -display none | egrep 'msa4|pc=
c-cmac-e?aes-256' | sort | uniq -c

Before and after:

          1                 "msa4-base": true,

Same with type "full":

    $ echo -e '{"execute": "qmp_capabilities"}\n{"execute": "query-cpu-mode=
l-expansion", "arguments": {"type": "full", "model": {"name": "qemu"}}}\n{"=
execute": "quit"}' | $i -qmp-pretty stdio -S -display none | egrep 'msa4|pc=
c-cmac-e?aes-256' | sort | uniq -c

Before:

          1                 "msa4-base": true,
          1                 "pcc-cmac-eaes-256": false,

After

          1                 "msa4-base": true,
          1                 "pcc-cmac-aes-256": false,
          1                 "pcc-cmac-eaes-256": false,

The grouping and masking you described appears to apply to
query-cpu-model-expansion with type "static".  With type "full", I can
see the grouping, but not the masking.  With query-cpu-definitions, I
can't see either.

I haven't played with query-cpu-model-comparison and
query-cpu-model-baseline.

>> But "'-cpu' setup" doesn't seem to be about reporting features.  Am I
>> confused?
>>=20
>
> Let me clarify. Any user input would be broken if the two sub-features
> would be specified explicitly, instead of the whole "msa4" group. This
> applies to any user input, also the user input for query-cpu-model-.
>
> In the usual cases, libvirt will expand a cpu model (e.g., "host",
> "z15") and start QEMU with that (-cpu ...). We will only have the
> complete msa4 group here in practice.
>
> Yes, if some user would pick and chose such features manually, it would
> be broken - it's just not the common on s390x with the huge amount of
> features. But that's why I thing stable backports still make sense.

The commit message should be accurate and sufficiently precise.  The
"sufficiently" gives me some wiggle room to avoid inaccuracy due to my
ignorance.  Would the following be good enough?

    Impact:
   =20
    * s390_feat_bitmap_to_ascii() misidentifies S390_FEAT_PCC_CMAC_AES_256
      as "pcc-cmac-eaes-256".  Affects QMP commands query-cpu-definitions,
      query-cpu-model-expansion, query-cpu-model-baseline,
      query-cpu-model-comparison, and the error message when
      s390_realize_cpu_model() fails in check_compatibility().
   =20
    * s390_cpu_list() also misidentifies it.  Affects -cpu help.
   =20
    * s390_cpu_model_register_props() creates CPU property
      "pcc-cmac-eaes-256" twice.  The second one fails, but the error is
      ignored (a later commit will change that).  Results in a single
      property "pcc-cmac-eaes-256" with the description for
      S390_FEAT_PCC_CMAC_AES_256, and no property for
      S390_FEAT_PCC_CMAC_EAES_256.  CPU properties are visible in CLI -cpu
      and -device, QMP & HMP device_add, QMP device-list-properties, and
      QOM introspection.

    The two features are almost always used via their group msa4.  Such
    use is not affected by this bug.

>> While testing, I noticed that
>>=20
>>     $ s390x-softmmu/qemu-system-s390x
>>=20
>> flashes a window at me, then terminates successfully, without printing
>> anything.  With -S, it behaves like other targets.  Bug?
>>=20
>
> Think this is expected.
>
> t480s: ~  $ qemu-system-s390x --nographic
> LOADPARM=3D[        ]
> Could not find a suitable boot device (none specified)
>
> The s390-ccw bios will come up, detect that there is nothing to boot and
> quit. The bios can only print to the sclp console, not to a graphical
> output.
>
> What the others do (e.g., ppc64, x86_64) is boot the bios/firmware and
> then halt there.

Thanks!


