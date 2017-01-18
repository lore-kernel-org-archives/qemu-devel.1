Received: from eggs.gnu.org ([2001:4830:134:3::10]:57952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cTmih-0001wX-Hf
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:39:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cTmie-0007FG-JK
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:39:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cTmie-0007DY-AJ
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 04:39:52 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7AA6088E60
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 09:39:49 +0000 (UTC)
References: <20170117010204.4909-1-ehabkost@redhat.com>
	<20170117010204.4909-10-ehabkost@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9b1bc94e-f1bf-d166-e796-16410a66bb93@redhat.com>
Date: Wed, 18 Jan 2017 10:39:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170117010204.4909-10-ehabkost@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
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
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

Am 17.01.2017 um 02:02 schrieb Eduardo Habkost:
> +    def checkExpansions(self, model, msg):
> +        """Perform multiple expansion operations on model, validate results
> +
> +        @model is a CpuModelExpansionInfo struct, with some extra keys:
> +        * model['runnable'] should be set to True if the CPU model is
> +          runnable on this host
> +        * model['qom-props'] will be set to the full list of properties for
> +          the CPU, if the model is runnable
> +        """
> +        exp_s = self.checkOneExpansion(model, 'static',
> +                                       '%s.static' % (msg))
> +        exp_f = self.checkOneExpansion(model, 'full',
> +                                       '%s.full' % (msg))
> +        exp_ss = self.checkOneExpansion(exp_s, 'static',
> +                                        '%s.static.static' % (msg))
> +        exp_sf = self.checkOneExpansion(exp_s, 'full',
> +                                        '%s.static.full' % (msg))
> +        exp_ff = self.checkOneExpansion(exp_f, 'full',
> +                                        '%s.full.full' % (msg))
> +
> +        # static expansion twice should result in the same data:
> +        self.assertEquals(exp_s, exp_ss, '%s: static != static+static' % (msg))
> +        # full expansion twice should also result in the same data:
> +        self.assertEquals(exp_f, exp_ff, '%s: full != full+full' % (msg))
> +
> +        # migration-safe CPU models have an extra feature:
> +        # their static expansion should be equivalent to the full
> +        # expansion (as their static expansion is also precise)

This is not true for s390x:

"z13-base" is both, static and migration-safe.

Doing a full expansion will expand all features (so your check against
QOM properties should succeed)

Doing a static expansion will expand no features, as z13-base is
already static, so there are no features to expand (no delta changes).

"z13" is only migration-safe.

Doing a full expansion will expand all features.

Doing a static expansion will only expand the features different to
"z13-base". (Remember, delta changes only to minimize reported
features).


And I wonder if that is also true for x86? This should only be true if
the "base" model contains absolutely no features.

> +        if self.isMigrationSafe(model['model']):
> +            self.assertEquals(exp_sf['model']['props'], exp_f['model']['props'],
> +                              '%s: props: static+full != full' % (msg))
> +            self.assertEquals(exp_sf.get('qom-props'), exp_f.get('qom-props'),
> +                              '%s: qom-props: static+full != full' % (msg))


-- 

David
