Received: from eggs.gnu.org ([2001:4830:134:3::10]:40685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLBTm-00045i-Fg
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dLBTj-0006fc-DG
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:49:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dLBTj-0006eh-49
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 12:49:11 -0400
References: <1497369290-20401-1-git-send-email-peter.maydell@linaro.org>
	<1497369290-20401-2-git-send-email-peter.maydell@linaro.org>
	<f279fd6d-d32f-79e8-66e3-62edc0e425a8@amsat.org>
	<937b2871-7380-4bfc-9a3b-997e496633ff@redhat.com>
	<7b7e4b38-923d-b928-ab09-716b2140273b@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7de47a0f-baad-d849-eebd-87c86dae16c1@redhat.com>
Date: Wed, 14 Jun 2017 18:49:05 +0200
MIME-Version: 1.0
In-Reply-To: <7b7e4b38-923d-b928-ab09-716b2140273b@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] travis: install more library
 dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, patches@linaro.org, Fam Zheng <famz@redhat.com>



On 14/06/2017 17:37, Philippe Mathieu-Daud=E9 wrote:
> On 06/14/2017 12:07 PM, Paolo Bonzini wrote:
>>
>>
>> On 14/06/2017 05:52, Philippe Mathieu-Daud=E9 wrote:
>>> As you said, due to Travis using Ubuntu still not all libs get detect=
ed
>>> but at least the following:
>>>
>>>  $ ./configure ${CONFIG}
>>> -VirtFS support    no
>>> +VirtFS support    yes
>>> -bluez  support    no
>>> +bluez  support    yes
>>> -xfsctl support    no
>>> +xfsctl support    yes
>>> -lzo support       no
>>> +lzo support       yes
>>> -snappy support    no
>>> +snappy support    yes
>>>
>>> Using debian based docker images on Shippable we also get:
>>>
>>> -nettle            no
>>> -nettle kdf        no
>>> +nettle            yes (3.3)
>>> +nettle kdf        yes
>>> -rbd support       no
>>> +rbd support       yes
>>> -vde support       no
>>> +vde support       yes
>>> -GlusterFS support no
>>> +GlusterFS support yes
>>> -libnfs support    no
>>> +libnfs support    yes
>>
>> So this leaves out only rdma and iscsi?
>>
>> I don't know travis vs. shippable very well, can you provide a similar
>> patch to shippable?
>=20
> Travis base images are Ubuntu based, as said Peter "some of our
> dependencies need versions that are closer to the bleeding edge than
> those distros provide".

Well, trusty is 3 years old by now... I wouldn't call that bleeding
edge, and it seems like Travis is suggesting using Docker images for
those who want to use a newer distro.  This patch and patch 2 are
useful, but I think I'd rather get full coverage, either with Shippable
or by keeping on doing manual builds, than to rush things and switch to
CI when it's not ready.

First, I don't think it's accurate to say that scans have been often
weeks or months apart:

			#days	#commits
	2017-06-05	4	123
	2017-06-01	14	214
	2017-05-18	3	108
	2017-05-15	8	262
	2017-05-07	12	149
	2017-04-25	24	317
	2017-04-01	4	 47
	2017-03-28	7	 86
	2017-03-21	4	 35
	2017-03-17	1	 29
	2017-03-16	2	107
	2017-03-14	5	 42
	2017-03-09	0	180
	2017-03-09	6	  0	(updated model file)
	2017-03-03	4	347
	2017-02-27	6	198
	2017-02-21	1	 62
	2017-02-20	0	 69
	2017-02-20	4	  0	(updated model file)

Until Coverity bumped the maximum frequency of builds, we were doing
scans pretty much as fast as we were allowed to (1 per week I think):

	2017-02-16	13	148
	2017-02-03	9	298
	2017-01-25	7	283
	2017-01-18	14	464
	2017-01-04	49	230
	2016-11-16	9	275
	2016-11-07	14	504
	2016-10-24	14	243
	2016-10-10	10	190
	2016-09-30

In the last eight months, there was exactly one case where the builds
were more than one month apart and one more case where the builds were
more than two weeks apart.  Both of them coincided with the two most
recent hard freeze periods (2.8 and 2.9).

Second, I don't even think that CI is particularly useful when someone
must actively consume those scans: triage newly-reported defects, inform
the authors of the patch, and so on.  Too many Coverity reports can be a
burden because you cannot use e.g. the "All newly detected" view.

Of course I'm all for making Coverity builds more accessible to people
with the project token, through better scripts and possibly integration
with the Docker testing targets.

Paolo
