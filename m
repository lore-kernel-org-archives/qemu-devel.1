Received: from eggs.gnu.org ([2001:4830:134:3::10]:33541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Richard.Relph@amd.com>) id 1dxHf6-0002bo-Nw
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Richard.Relph@amd.com>) id 1dxHf0-0001ep-AH
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:06:24 -0400
Received: from mail-by2nam01on0043.outbound.protection.outlook.com
	([104.47.34.43]:3248
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Richard.Relph@amd.com>)
	id 1dxHez-0001dZ-Lc
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:06:18 -0400
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170926170901-mutt-send-email-mst@kernel.org>
	<2fb6e86d-5afa-d7f0-6f62-8f81db5a5419@amd.com>
	<20170927190724-mutt-send-email-mst@kernel.org>
From: Richard Relph <richard.relph@amd.com>
Message-ID: <927fedc3-a2c8-d37c-930e-11cecb7b0149@amd.com>
Date: Wed, 27 Sep 2017 14:06:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170927190724-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>
Cc: qemu-devel@nongnu.org, libvir-list@redhat.com, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>

Forgive the top post... some of the conversation has been trimmed, but I 
need to go back to first principles of SEV in order to make sure we all 
have a clear understanding of what the goal is.

The goal - for BOTH guest owner and cloud provider - is to get to a VM 
where ONLY the guest owner (GO) has access to the GO "secrets". 
Legitimate cloud providers (ie, those that wish to not retain a back 
door in to their customer's VMs) want this every bit as much as GOs want 
it. It is this privacy concern that some believe holds back broader 
adoption of public cloud for sensitive applications.

To provide this additional privacy will require some changes to the 
"untrustable" model that seems to be in place now. There is value for 
everyone in creating a "trustable" model.

Given that, the root of the problem for the GO is trust. How can the GO 
know that every instruction in their VM is "theirs"? AMD Epyc CPUs 
decrypt every instruction fetch (and guest page table walk) in an SEV 
guest VM with that VM's random memory encryption key. (Data can either 
be encrypted or not, at the guest's choosing.) Only the SEV FW and the 
guest itself can encrypt memory with that key. The SEV FW measures every 
byte it encrypts for the guest and provides that measurement to the GO. 
The GO is free to ignore the value and run the guest "as-is". But 
recommended practice will be to inspect the measurement, verify it, and 
only then provide the guest VM with "secrets" necessary to decrypt 
disks, connect to privileged network resources, etc.

As has been observed, the BIOS has a great deal of power. It is 
impossible to maintain the GO's privacy in a VM where the BIOS (or any 
other code, for that matter) is "unknown". It simply is a violation of 
the trust model both the GO and the CP want to have to allow unknown 
code from the CP to enter the GO's VM. (Yes, there are LOTS of other 
ways for untrusted code to get in and secrets to get out... we're only 
trying to close this door between the CP and the guest VM at this time. ;-)

I anticipate that legitimate cloud providers will be happy (or at least 
willing) to share with customers the source for their BIOS. The GO can 
inspect the source, build the binary from that source, and generate the 
required hash. Or they may just trust that someone else has done that 
work and accept the hash the CP posts on their BIOS image. (Note that 
when the hash is returned by the SEV FW, it is in HMAC form, with a 
nonce that the GO can compute, and a key the GO provided at launch time.)

Whether the "BIOS" is a "static shim" as Michael suggests, or a full 
BIOS, or even a BIOS+kernel+initrd is really not too significant. What 
is significant is that the GO has a basis for trusting all code that is 
imported in to their VM by the CP. And that NONE of the code provided by 
the CP is "unknown" and unauditable by the GO. If the CP has a way to 
inject code unknown to the GO in to the guest VM, the trust model is 
broken and both GO and CP suffer the consequences.

When the CP needs to update the BIOS image, they will have to inform the 
GO and allow the GO to establish trust in the CP's new BIOS image somehow.

I hope that helps outline what we're doing, and why.

Richard


On 9/27/17 11:12 AM, Michael S. Tsirkin wrote:
> On Wed, Sep 27, 2017 at 08:39:24AM -0500, Brijesh Singh wrote:
>> Hi Michael,
>>
>>
>> On 09/26/2017 09:36 AM, Michael S. Tsirkin wrote:
>>
>> ...
>>
>>>> 8. libvirt launches the guest with "-S"
>>>> 9. While creating the SEV guest qemu does the following
>>>>    i) create encryption context using GO's DH, session-info and guest policy
>>>>       (LAUNCH_START)
>>>>    ii) encrypts the guest bios (LAUNCH_UPDATE_DATA)
>>>>    iii) calls LAUNCH_MEASUREMENT to get the encrypted bios measurement
>>>
>>> This part troubles me. This seems to mean that the guest being launched
>>> must know what the measurement of the bios is going to be.  This means
>>> that the cloud provider can not update the bios without breaking guests.
>>> Also, while in practice you typically can run an old bios image on a new
>>> qemu instance, this is not really tested so would be very hard to
>>> support properly in QEMU.
>>>
>>>
>>
>>
>> The guest itself does not need to know the measurement of the bios --
>> the SEV launch flow empowers the GO to validate the bootstrap code (bios)
>> before GO can provide a confidential information to the guest. Please note
>> that the validating of the measurement flow is optional. GO can ask cloud
>> provider to ignore the measurement all together and boot the SEV guest.
> 
> As the OS runs on top of the bios, it does not seem prudent to boot the
> SEV guest without a way to verify that the bios is safe to use.
> Linux generally trusts the firmware it runs on. Are you looking for
> examples of how a malicious firmware can leak info out of the guest?
> 
>> The measurement flow can be useful when GO decides to provide a custom
>> bios and want to know that his bios is used for booting the guest. In this
>> case, since the guest owner knows the initial contents of the guest at boot,
>> he can request the measurement from the cloud provider and compare it with
>> what the guest owner expects.
> 
> I agree the measurement works for this, but If that's the only case, I'd
> say it's not all that interesting since most people will use a standard
> bios.
> 
> I do think something needs to vaidate the bios though, and I do not
> think naively measuring the hash of the full bios is a way to do this
> that we can support well long term.
> 
>>
>>
>>> And this looks like a fundamental problem with the hash based
>>> measurement that's in hardware. So below I suggest that we layer
>>> some software on top to rely on the hash as little as possible.
>>>
>>>
>>>
>>>> 10. By some interface we must propagate the measurement all the way to GO
>>>>     before libvirt starts the guest.
>>>> 11. GO verifies the measurement and if measurement matches then it may
>>>>    give a secret blob -- which must be injected into the guest before
>>>>    libvirt starts the VM. If verification failed, GO will request cloud
>>>>    provider to destroy the VM.
>>>> 12. After secret blob is injected into guest, we call LAUNCH_FINISH
>>>>     to destory the encryption context.
>>>> 13. libvirt issues "continue" command to resume the guest boot.
>>>>
>>>> Please note that the measurement value is protected with transport
>>>> encryption key (TIK) and it changes on each run. Similarly the secret blob
>>>> provided by GO does not need to be protected using libvirt/qemu APIs. The
>>>> secret is protected by TIK. From qemu and libvirt point of view these are
>>>> blobs and must be passed as-is to the SEV FW.
>>>
>>> So here's an alternative idea for starting guests:
>>>
>>> How about building a minimal shim firmware that
>>> runs on a single CPU and uses no hardware at all,
>>> it just contains the secret blob.
>>>
>>> That firmware just immediately stops and signals
>>> hypervisor that it is ready to be run in the cloud.
>>>
>>> Have user generate and start this shim firmware as a guest in a private
>>> setup, then export it out using SEND_* commands.
>>>
>>> Then instead of asking to launch guest, you ask provider
>>> to load it with RECEIVE_* commands.
>>>
>>> Unlike bios the shim firmware
>>> can hopefully be static so supporting it across qemu
>>> versions should be easy.
>>>
>>> The shim firmware then loads bios from qemu, verifies
>>> it in any way it sees fit (e.g. it could check a signature, version, etc:
>>> it is not limited to a hardware hash anymore).
>>> It then jumps to the bios.
>>>
>>>
>>> While not exactly the same, there is some similarity
>>> here with how people solved the issues around secureboot -
>>> by using a shim.
>>>
