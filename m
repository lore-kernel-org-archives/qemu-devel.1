Received: from eggs.gnu.org ([2001:4830:134:3::10]:32860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Richard.Relph@amd.com>) id 1dtvMY-00020u-4s
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:41:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Richard.Relph@amd.com>) id 1dtvMT-0002aw-0L
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:41:22 -0400
Received: from mail-by2nam01on0079.outbound.protection.outlook.com
	([104.47.34.79]:44624
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Richard.Relph@amd.com>)
	id 1dtvMS-0002ad-GK
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:41:16 -0400
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170908131555.GD32645@redhat.com>
	<9BF693FD-B1CD-4813-86B4-4A909D8847A1@amd.com>
	<20170908145201.GJ32645@redhat.com> <20170918094357.GB24642@erzo-ntb>
	<20170918094748.GD2951@redhat.com>
From: Richard Relph <richard.relph@amd.com>
Message-ID: <9b7231b0-b17e-5627-7a0b-20c42aec9480@amd.com>
Date: Mon, 18 Sep 2017 07:41:09 -0500
MIME-Version: 1.0
In-Reply-To: <20170918094748.GD2951@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [libvirt]  libvirt/QEMU/SEV interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Erik Skultety <eskultet@redhat.com>
Cc: "libvir-list@redhat.com" <libvir-list@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



On 9/18/17 4:47 AM, Daniel P. Berrange wrote:
> On Mon, Sep 18, 2017 at 11:43:57AM +0200, Erik Skultety wrote:
>> [...]
>>
>>>>      > c) what existing communicate interface can be used between libvirt and qemu
>>>>      > to get the measurement ? can we add a new qemu monitor command
>>>>      > 'get_sev_measurement' to get the measurement ? (step 10)
>>>>
>>>>      Yes, QMP commands seeem most likely.
>>>>
>>>>      > d) how to pass the secret blob from libvirt to qemu ? should we consider
>>>>      > adding a new object (sev-guest-secret) -- libvirt can add the object through
>>>>      > qemu monitor.
>>>>
>>>>      Yeah, that looks like a viable option too.
>>> So I could see a flow like the following:
>>>
>>>
>>>    1. mgmt tool calls  virConnectGetCapabilities. This returns an XML
>>>       document that includes the following
>>>
>>>        <host>
>>>           ...other bits...
>>>          <sev>
>>> 	  <platform-key>...hex encoded PDH key...</platform-key>
>>> 	</sev>
>>>        </host>
>>>
>>>    2. mgmt tool requests to start a guest calling virCreateXML(),
>>>       passing VIR_DOMAIN_START_PAUSED. The XML would include
>>>
>>>        <sev>
>>>          <owner-key>...hex encode DH key...</owner-key>
>>> 	<session-info>..hex encode info...</session-info>
>>> 	<policy>...int32 value..</policy>
>>>        </sev>
>>>
>>>
>>>       if <sev> is provided and VIR_DOMAIN_START_PAUSED is missing,
>>>       libvirt would report an error and refuse to start the guest
For ease of use, I would not add this conditional to libvirt. If <sev> 
is provided and VIR_DOMAIN_START_PAUSED is missing, I’d just send the 
"GO" command as it would naturally occur.
Unless that would confuse things inside libvirt or QEMU in relation to 
the measurement and secret…
Many of our existing tests focus on other aspects of SEV functionality 
and so they skip the MEASURE/SECRET phase of launch and just go 
immediately from LAUNCH_UPDATE_DATA (or VMSA) to LAUNCH_FINISH.
I guess the key question will be how will QEMU know when to get the 
MEASUREMENT and wait for a LAUNCH_SECRET before doing a LAUNCH_FINISH 
when connected to libvirt.
Brijesh, this is your area. It feels to me like QEMU will have to wait 
to do the LAUNCH_FINISH until it gets the first “go” from libvirt. If 
that’s right, and assuming the same “go” comes from libvirt with or 
without VIR_DOMAIN_START_PAUSED, then I’d simply exclude the conditional 
check. QEMU would get the measurement when it is done sending the data.
Though in “real world” uses, I think the conditional is perfectly OK.
>>>
>>>    3. Libvirt generates the QEMU cli arg to enable SEV using
>>>       the XML data and starts QEMU, leaving CPUs paused
>>>
>>>    4. QEMU emits a SEV_MEASURE event containing the measurement
>>>       blob
>> Speaking of which, I expect QEMU to have a QMP command to retrieve the
>> measurement, in which case I think libvirt has to provide an API for the user
>> to retrieve the measurement in case libvirtd crashes somewhere between setting
>> up QEMU and waiting for the measurement event from QEMU, or simply because the
>> GO missed the event for some unspecified reason.
> Yeah, that's a good point - we also ought to have a pause-reason that
> reflects that it is paused due to waiting for SEV secrets.
>
>>>    5. Libvirt catches the QEMU event and emits its own
>>>       VIR_CONNECT_DOMAIN_EVENT_SEV_MEASURE event containing
>>>       the measurement blob
>>>
>>>    6. GO does its validation of the measurement
>>>
>>>    7a  If validation failed, then virDomainDestroy() to stop QEMU
>>>
>>>    7b  If validation succeeed
>>>
>>>       Optionally call
>>>
>>>           virDomainSetSEVSecret()
>> Given the fact that we're likely introducing a new <sev> element to the XML
>> config, I'm more inclined to utilizing the existing virSecret interfaces (as
>> was originally suggested) instead of creating a vendor-specific API. You could
>> have an optional secret sub-element within the <sev> element and libvirt would
>> simply check if that secret has a value set, once the GO issues
>> virDomainResume(). Any particular reason for having a specific API for this that
>> I'm missing?
> Initially I was intending to suggest extensive use of virSecret, but it
> turns out that despite being called a "secret", none of the SEV data we are
> passing around needs protection. Either it is safe to be public, or it is
> already encrypted.  So essentially we just have some data blobs we need to
> pass into QEMU. I didn't feel we ought to be abusing virSecret as a
> general purpose mechanism for passing in opaque data blobs which do not
> need any kind of protection.
All of the above looks really good to me.
While I agree with Daniel’s analysis of the need for “secret”, I do like 
using virSecret to convey the notion of secrecy. But it isn’t necessary. 
The end points are the SEV FW and the guest owner and all secrets they 
share are already encrypted. Embedding it in the “GO” command feels 
equally OK to me.
Note that sending a secret with a “GO” other than the first one is an 
error… I don’t think libvirt needs to catch that, though. The SEV FW will.

> Regards,
> Daniel
Thanks,
Richard
