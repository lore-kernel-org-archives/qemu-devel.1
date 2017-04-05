Received: from eggs.gnu.org ([2001:4830:134:3::10]:33087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1cvf3X-00081B-7Q
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 03:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarnath.valluri@intel.com>) id 1cvf3U-0007DA-36
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 03:08:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:62232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarnath.valluri@intel.com>)
	id 1cvf3T-0007D6-QE
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 03:08:36 -0400
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
From: Amarnath Valluri <amarnath.valluri@intel.com>
Message-ID: <6a70868f-8831-54ce-5c67-c325acf03fec@intel.com>
Date: Wed, 5 Apr 2017 10:09:38 +0300
MIME-Version: 1.0
In-Reply-To: <20170403170738.GC2768@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, patrick.ohly@intel.com, stefanb@linux.vnet.ibm.com



On 03.04.2017 20:07, Daniel P. Berrange wrote:
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
Both spawning inside qemu and connecting to already running swtpm has 
its own pros, Hence we can make this spawning as backend configuration 
detail, So it looks like this:

-tpmdev 
emulator,id=id,tpmstatedir=dir[,spawn=[on|off],data-path=path,ctrl-path=path,logfile=path,loglevel=number]
   Options details:
      tpmstatedir - Directory path, which swtpm should  use for storing  
TPM state
      *spawn      - should spawn new process, defaults to 'off'
      *path         - swtpm binary path to spawn, ignored if spawn is off
      *data-path - Socket path to use/connect for data messages
      *ctrl-path   - Socket path to use/connect for out-of-band control 
messages
      *logfile       - File path to use for swtpm logs
      *loglevel    - log level number, defaults to 5 (ignored if no 
logfile provided)

-  If spawn is off, data-path and ctrl-path must be provided to qemu, 
where to connect already running swtpm
-  If spawn if on, both data-path and ctrl-path are optional. If not 
provided, qemu uses socket pairs to communicates with swptm, as it is 
doing now.

Hope this satisfies all usecases, if everyone here happy with this i can 
submit the new patch with these changes.

- Amarnath
