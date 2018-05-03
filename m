Received: from eggs.gnu.org ([2001:4830:134:3::10]:59118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEI3V-0007BN-Tx
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEI3S-0001MC-Pf
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:30:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48302 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fEI3S-0001M5-Jd
	for qemu-devel@nongnu.org; Thu, 03 May 2018 13:30:06 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180503012546.2170-1-famz@redhat.com>
	<20180503012546.2170-2-famz@redhat.com>
	<20180503091216.GD11382@redhat.com>
	<38bb4fbe-481e-b859-c4bc-bcdb9dba0957@redhat.com>
Date: Thu, 03 May 2018 19:29:59 +0200
In-Reply-To: <38bb4fbe-481e-b859-c4bc-bcdb9dba0957@redhat.com> (Eric Blake's
	message of "Thu, 3 May 2018 09:53:18 -0500")
Message-ID: <87a7tgejfs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/2] slirp: Add "query-usernet" QMP
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Eric Blake <eblake@redhat.com> writes:

> On 05/03/2018 04:12 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Thu, May 03, 2018 at 09:25:45AM +0800, Fam Zheng wrote:
>>> HMP "info usernet" has been available but it isn't ideal for programmed
>>> use cases. This closes the gap in QMP by adding a counterpart
>>> "query-usernet" command. It is basically translated from
>>> the HMP slirp_connection_info() loop, which now calls the QMP
>>> implementation and prints the data, just like other HMP info_* commands.
>>>
>>> The TCPS_* macros are now defined as a QAPI enum.
>>>
>>> Signed-off-by: Fam Zheng <famz@redhat.com>
>>
>
>>> +##
>>> +{ 'enum': 'TCPS',
>>
>> I'd suggest avoiding the abbreviation, IOW use  TCPState as
>> the name. Yes that will require changnig the constants in
>> the SLIRP code, but that's worthwhile to get this QAPI
>> naming clearer IMHO.
>>
>> I wonder if we should have a common prefix too eg UsernetTCPState
>> as this is a global QAPI namespace after all .
>
> You could also use
>
> { 'enum': 'UsernetTCPState', 'prefix': 'TCPS', ...
>
> for minimizing code churn (if 'prefix' is present, that overrides what
> the generator would use for enum values); although I'm not sure if
> that is any better (we haven't used 'prefix' much, and Markus wasn't
> the biggest fan of it in the first place, as it is more of a hack).

Please avoid 'prefix' unless you have a really, really good reason to
use it.

    $ git-grep TCPS_ | wc -l
    99

doesn't look like one.
