Received: from eggs.gnu.org ([2001:4830:134:3::10]:56710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZj3z-00062y-3E
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:58:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cZj3u-00074o-8p
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:58:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cZj3u-00074d-2W
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 13:58:22 -0500
References: <20170203170925.12554-1-rjones@redhat.com>
	<20170203170925.12554-2-rjones@redhat.com>
	<2f5ef524-02d7-e0e8-c693-db932f8270b9@redhat.com>
	<20170203185624.GB13825@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <25dc57d6-ded3-9e4a-92cf-e678d0c92a27@redhat.com>
Date: Fri, 3 Feb 2017 10:58:15 -0800
MIME-Version: 1.0
In-Reply-To: <20170203185624.GB13825@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] qemu-nbd: Implement socket activation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: stefanha@gmail.com, qemu-devel@nongnu.org, dplotnikov@virtuozzo.com, rkagan@virtuozzo.com, den@openvz.org



On 03/02/2017 10:56, Richard W.M. Jones wrote:
> On Fri, Feb 03, 2017 at 09:31:43AM -0800, Paolo Bonzini wrote:
>>
>>
>> On 03/02/2017 09:09, Richard W.M. Jones wrote:
>>> +                                                   const char *port,
>>> +                                                   bool fork_process)
>>> +{
>>> +    if (device != NULL) {
>>> +        return "NBD device can't be set when using socket activation";
>>> +    }
>>> +
>>> +    if (sockpath != NULL) {
>>> +        return "Unix socket can't be set when using socket activation";
>>> +    }
>>> +
>>> +    if (address != NULL) {
>>> +        return "The interface can't be set when using socket activation";
>>> +    }
>>> +
>>> +    if (port != NULL) {
>>> +        return "TCP port number can't be set when using socket activation";
>>> +    }
>>> +
>>> +    if (fork_process) {
>>> +        return "Fork (--fork) can't be used with socket activation";
>>> +    }
>>
>> Why not?  You could have a Type=forking foo.service, which makes little
>> sense but would work.
> 
> The answer, I think, is because systemd will lose track of the PID of
> the qemu-nbd process.  This would be important because systemd can
> kill a socket-activated service which is idle.
> 
> Normally you would work around that by using PIDFile=... in the unit
> file, but it looks like qemu-nbd doesn't support pid files.

PIDFile is recommended indeed but GuessMainPID=yes (the default for no
PIDFile) should work, since qemu-nbd only has one parent process.

Paolo
