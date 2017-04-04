Received: from eggs.gnu.org ([2001:4830:134:3::10]:58339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cvNGe-0001Cw-7k
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cvNGa-0007TU-92
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:09:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1cvNGa-0007Su-0M
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 08:08:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v34C58oV058862
	for <qemu-devel@nongnu.org>; Tue, 4 Apr 2017 08:08:53 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29kydg82mn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 04 Apr 2017 08:08:52 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 4 Apr 2017 08:08:51 -0400
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 4 Apr 2017 08:08:47 -0400
MIME-Version: 1.0
In-Reply-To: <20170403170738.GC2768@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <f2a9a90b-c4ed-56f0-7ee9-608d29088b68@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/7] Provide support for the software TPM
 emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>
Cc: patrick.ohly@intel.com, qemu-devel@nongnu.org

On 04/03/2017 01:07 PM, Daniel P. Berrange wrote:
> On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wrote:
>> Briefly, Theses set of patches introduces:
>>   - new TPM backend driver to support software TPM emulators(swtpm(1)).
>>   - and few supported fixes/enhancements/cleanup to existing tpm backend code.
>>
>> The similar idea was initiated earliar(2) by Stefan Berger(CCed) with slightly
>> different approach, using CUSE. As swtpm has excellent support for unix domain
>> sockets, hence this implementation uses unix domain sockets to communicate with
>> swtpm.
>>
>> When Qemu is configured with 'emulator' tpm backend, it spawns 'swtpm' and
>> communicates its via Unix domain sockets.
> I'm not convinced that having QEMU spawning swtpm itself is a desirable
> approach, as it means QEMU needs to have all the privileges that swtpm
> will need, so that swtpm can inherit them. At the very least I think we
> need to have a way to disable this spawning, so it can connect to a
> pre-existing swtpm process that's been spawned ahead of time. This will
> let us have stricter privilege separation.
I had implemented it like that. For this I have a libvirt driver that 
starts swtpm, sets up cgroups for swtpm (e.g., CPU consumption limits), 
and drops unnecessary Linux capabilities...

    Stefan
