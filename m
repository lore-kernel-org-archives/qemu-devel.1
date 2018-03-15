Received: from eggs.gnu.org ([2001:4830:134:3::10]:48301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewRWR-00019P-Lu
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:58:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewRWQ-0001I0-Qn
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 07:58:15 -0400
References: <1521100145-15304-1-git-send-email-thuth@redhat.com>
	<1521100145-15304-3-git-send-email-thuth@redhat.com>
	<20180315092110.GD3146@redhat.com>
	<3d3a009b-37c3-86b0-a734-e1783f507e60@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d7ffdd54-8976-a406-6837-4a5170ca900d@redhat.com>
Date: Thu, 15 Mar 2018 06:57:51 -0500
MIME-Version: 1.0
In-Reply-To: <3d3a009b-37c3-86b0-a734-e1783f507e60@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/cdboot: Test booting from CD-ROM
 ISO image file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Victor Kaplansky <victork@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 03/15/2018 05:48 AM, Thomas Huth wrote:

>>> +    pid = fork();
>>> +    if (pid == 0) {
>>> +        va_start(args, fmt);
>>> +        params = g_strdup_vprintf(fmt, args);
>>> +        va_end(args);
>>> +        command = g_strdup_printf("exec genisoimage %s", params);
>>> +        g_free(params);
>>> +        execlp("/bin/sh", "sh", "-c", command, NULL);
>>> +        exit(1);
>>> +    }
>>> +    wait(&status);
>>
>> IMHO this should just use g_spawn_sync(), also the use of
>> shell seems rather unneccessary

and potentially dangerous - if we aren't absolutely positive that we 
aren't going to improperly expand shell metacharacters embedded in params.

>> - why not just run genisoimage
>> directly ?
> 
> That code was simply "inspired" from the execlp() code in
> qtest_init_without_qmp_handshake()

Sounds like a good idea for a future cleanup patch ;)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
