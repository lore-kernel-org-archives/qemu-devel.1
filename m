Received: from eggs.gnu.org ([2001:4830:134:3::10]:59981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dqLrI-0007jL-Lo
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:10:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1dqLrF-0004Kh-GW
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:10:20 -0400
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com
	([104.47.33.74]:47280
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1dqLrF-0004KB-7a
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 12:10:17 -0400
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170908131555.GD32645@redhat.com>
	<9BF693FD-B1CD-4813-86B4-4A909D8847A1@amd.com>
	<20170908145201.GJ32645@redhat.com>
	<82d6b8f0-7101-1d59-5489-43b66107fbe0@amd.com>
	<20170908155143.GK32645@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <4df908ab-bd78-eb39-63f5-9fbcf7f07403@amd.com>
Date: Fri, 8 Sep 2017 11:10:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170908155143.GK32645@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: brijesh.singh@amd.com, "Relph, Richard" <Richard.Relph@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>



On 09/08/2017 10:51 AM, Daniel P. Berrange wrote:
> On Fri, Sep 08, 2017 at 10:48:10AM -0500, Brijesh Singh wrote:
>>> So I could see a flow like the following:
>>
>>
>> The flow looks good
>>
>>>
>>>
>>>     1. mgmt tool calls  virConnectGetCapabilities. This returns an XML
>>>        document that includes the following
>>>
>>>         <host>
>>>            ...other bits...
>>>           <sev>
>>> 	  <platform-key>...hex encoded PDH key...</platform-key>
>>> 	</sev>
>>>         </host>
>>>
>>>     2. mgmt tool requests to start a guest calling virCreateXML(),
>>>        passing VIR_DOMAIN_START_PAUSED. The XML would include
>>>
>>>         <sev>
>>>           <owner-key>...hex encode DH key...</owner-key>
>>> 	<session-info>..hex encode info...</session-info>
>>> 	<policy>...int32 value..</policy>
>>>         </sev>
>>>
>>>
>>>        if <sev> is provided and VIR_DOMAIN_START_PAUSED is missing,
>>>        libvirt would report an error and refuse to start the guest
>>>
>>
>>
>> One thing which is not clear to me is, how do we know that we are asked
>> to launch SEV guest? Are you thinking that <sev> tag in the XML will
>> hint libvirt that GO has asked to launch a SEV guest?
> 
> Yes, the existance of the <sev> tag is the indicator that informs
> libvirt that SEV *must* be used for the guest.


Thanks for confirming.


> 
>>>     3. Libvirt generates the QEMU cli arg to enable SEV using
>>>        the XML data and starts QEMU, leaving CPUs paused
>>>
>>
>>
>> I am looking at [1] to get the feel for how do we model it in the XML.
>> As you can see I am using ad-hoc <qemu:args> to create the sev-guest
>> object. Currently, sev-guest object accepts the following properties:
>>
>> dh-cert-file: <file containing the GO DH key>
>> session-info-file: <file contain the GO session info>
>> policy: <int32 GO policy>
>>
>> I believe the new XML model will influence the property input type,
>> Any recommendation on how do model this part ? thank you so much.
> 
> That looks ok to me - even if QEMU wants the data provided in
> files on disk, libvirt can just create the files on the fly
> from the data it has in the <sev> element in the XML file.
> Since they're only needed during startup, libvirt can then
> easily delete the files the moment QEMU has completed its
> startup.
> 

Perfect! works well with me.
