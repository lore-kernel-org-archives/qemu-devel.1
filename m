Received: from eggs.gnu.org ([2001:4830:134:3::10]:56752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cvmTn-0004Ne-QL
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cvmTk-0003P3-Lq
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:04:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53988
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1cvmTk-0003Oq-GL
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:04:12 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v35F3mbf071949
	for <qemu-devel@nongnu.org>; Wed, 5 Apr 2017 11:04:11 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29n14wxqt5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 11:04:10 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 5 Apr 2017 11:04:10 -0400
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
	[9.57.199.111])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v35F483H45744230
	for <qemu-devel@nongnu.org>; Wed, 5 Apr 2017 15:04:08 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D231DAC05E
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 11:03:57 -0400 (EDT)
Received: from sbct-3.watson.ibm.com (unknown [9.2.141.158])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP id C814DAC059
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 11:03:57 -0400 (EDT)
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
	<6a70868f-8831-54ce-5c67-c325acf03fec@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 11:04:07 -0400
MIME-Version: 1.0
In-Reply-To: <6a70868f-8831-54ce-5c67-c325acf03fec@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <b894f5b7-64ad-7696-b3fe-82941e2d6c5b@linux.vnet.ibm.com>
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
To: qemu-devel@nongnu.org

On 04/05/2017 03:09 AM, Amarnath Valluri wrote:
>
>
> On 03.04.2017 20:07, Daniel P. Berrange wrote:
>> On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wrote:
>>> Briefly, Theses set of patches introduces:
>>>   - new TPM backend driver to support software TPM emulators(swtpm(1)).
>>>   - and few supported fixes/enhancements/cleanup to existing tpm 
>>> backend code.
>>>
>>> The similar idea was initiated earliar(2) by Stefan Berger(CCed) 
>>> with slightly
>>> different approach, using CUSE. As swtpm has excellent support for 
>>> unix domain
>>> sockets, hence this implementation uses unix domain sockets to 
>>> communicate with
>>> swtpm.
>>>
>>> When Qemu is configured with 'emulator' tpm backend, it spawns 
>>> 'swtpm' and
>>> communicates its via Unix domain sockets.
>> I'm not convinced that having QEMU spawning swtpm itself is a desirable
>> approach, as it means QEMU needs to have all the privileges that swtpm
>> will need, so that swtpm can inherit them. At the very least I think we
>> need to have a way to disable this spawning, so it can connect to a
>> pre-existing swtpm process that's been spawned ahead of time. This will
>> let us have stricter privilege separation.
> Both spawning inside qemu and connecting to already running swtpm has 
> its own pros, Hence we can make this spawning as backend configuration 
> detail, So it looks like this:
>
> -tpmdev 
> emulator,id=id,tpmstatedir=dir[,spawn=[on|off],data-path=path,ctrl-path=path,logfile=path,loglevel=number]
>   Options details:
>      tpmstatedir - Directory path, which swtpm should  use for 
> storing  TPM state
>      *spawn      - should spawn new process, defaults to 'off'
>      *path         - swtpm binary path to spawn, ignored if spawn is off
>      *data-path - Socket path to use/connect for data messages
>      *ctrl-path   - Socket path to use/connect for out-of-band control 
> messages

FD passing would work?

>      *logfile       - File path to use for swtpm logs
>      *loglevel    - log level number, defaults to 5 (ignored if no 
> logfile provided)
>
> -  If spawn is off, data-path and ctrl-path must be provided to qemu, 
> where to connect already running swtpm
> -  If spawn if on, both data-path and ctrl-path are optional. If not 
> provided, qemu uses socket pairs to communicates with swptm, as it is 
> doing now.
>
> Hope this satisfies all usecases, if everyone here happy with this i 
> can submit the new patch with these changes.
>
> - Amarnath
>
