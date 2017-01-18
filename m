Received: from eggs.gnu.org ([2001:4830:134:3::10]:41652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cTpZ1-000105-S8
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:42:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cTpZ1-0003eq-0d
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:42:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cTpZ0-0003eU-O4
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 07:42:06 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CFF5515F55F
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 12:42:06 +0000 (UTC)
References: <20170117010204.4909-1-ehabkost@redhat.com>
	<20170117010204.4909-10-ehabkost@redhat.com>
	<9b1bc94e-f1bf-d166-e796-16410a66bb93@redhat.com>
	<20170118123957.GQ3491@thinpad.lan.raisama.net>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2213f682-abbc-e00c-f7b0-2439a400a18d@redhat.com>
Date: Wed, 18 Jan 2017 13:42:04 +0100
MIME-Version: 1.0
In-Reply-To: <20170118123957.GQ3491@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 9/9] tests: Test case for
 query-cpu-model-expansion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org

Am 18.01.2017 um 13:39 schrieb Eduardo Habkost:
> On Wed, Jan 18, 2017 at 10:39:46AM +0100, David Hildenbrand wrote:
>> Am 17.01.2017 um 02:02 schrieb Eduardo Habkost:
>>> +    def checkExpansions(self, model, msg):
>>> +        """Perform multiple expansion operations on model, validate results
>>> +
>>> +        @model is a CpuModelExpansionInfo struct, with some extra keys:
>>> +        * model['runnable'] should be set to True if the CPU model is
>>> +          runnable on this host
>>> +        * model['qom-props'] will be set to the full list of properties for
>>> +          the CPU, if the model is runnable
>>> +        """
>>> +        exp_s = self.checkOneExpansion(model, 'static',
>>> +                                       '%s.static' % (msg))
>>> +        exp_f = self.checkOneExpansion(model, 'full',
>>> +                                       '%s.full' % (msg))
>>> +        exp_ss = self.checkOneExpansion(exp_s, 'static',
>>> +                                        '%s.static.static' % (msg))
>>> +        exp_sf = self.checkOneExpansion(exp_s, 'full',
>>> +                                        '%s.static.full' % (msg))
>>> +        exp_ff = self.checkOneExpansion(exp_f, 'full',
>>> +                                        '%s.full.full' % (msg))
>>> +
>>> +        # static expansion twice should result in the same data:
>>> +        self.assertEquals(exp_s, exp_ss, '%s: static != static+static' % (msg))
>>> +        # full expansion twice should also result in the same data:
>>> +        self.assertEquals(exp_f, exp_ff, '%s: full != full+full' % (msg))
>>> +
>>> +        # migration-safe CPU models have an extra feature:
>>> +        # their static expansion should be equivalent to the full
>>> +        # expansion (as their static expansion is also precise)
>>
>> This is not true for s390x:
>>
>> "z13-base" is both, static and migration-safe.
>>
>> Doing a full expansion will expand all features (so your check against
>> QOM properties should succeed)
>>
>> Doing a static expansion will expand no features, as z13-base is
>> already static, so there are no features to expand (no delta changes).
>>
>> "z13" is only migration-safe.
>>
>> Doing a full expansion will expand all features.
>>
>> Doing a static expansion will only expand the features different to
>> "z13-base". (Remember, delta changes only to minimize reported
>> features).
> 
> I think my comment was confusing. By "equivalent" I don't mean
> having the same expansion, but resulting in the same set of
> features.
> 
> This is not comparing full_expansion(model) and
> static_expansion(model). It is comparing full_expansion(model)
> full_expansion(static_expansion(model)).
> 
> In other words, absolutely no feature should be lost or changed
> during static expansion, and we verify that by doing a full
> expansion after the static expansion (exp_sf) and comparing the
> results with the full expansion (exp_f).
> 
> I believe this is true on s390x too, isn't it?

Okay, I actually was confused by this comment. This makes sense!

full(z13) == full(static(z13))

Thanks for clarifying!

-- 

David
