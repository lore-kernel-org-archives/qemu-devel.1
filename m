Received: from eggs.gnu.org ([2001:4830:134:3::10]:44915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCRGM-0004j0-1B
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gCRGI-0006iG-T7
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:28:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51632)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gCRGI-0006gf-L9
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:27:58 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ADCDAC04BD42
	for <qemu-devel@nongnu.org>; Tue, 16 Oct 2018 15:27:57 +0000 (UTC)
References: <20181015115309.17089-1-armbru@redhat.com>
	<20181015115309.17089-34-armbru@redhat.com>
	<31daa4d5-96bf-ac50-7a3d-e503b13c9872@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6cd31259-da19-294e-0cf7-95f215525d33@redhat.com>
Date: Mon, 15 Oct 2018 13:54:34 -0500
MIME-Version: 1.0
In-Reply-To: <31daa4d5-96bf-ac50-7a3d-e503b13c9872@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 33/35] blockdev: Convert drive_new() to
 Error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>

On 10/15/18 9:48 AM, Max Reitz wrote:
> On 15.10.18 13:53, Markus Armbruster wrote:
>> Calling error_report() from within a function that takes an Error **
>> argument is suspicious.  drive_new() calls error_report() even though
>> it can run within drive_init_func(), which takes an Error ** argument.
>> drive_init_func()'s caller main(), via qemu_opts_foreach(), is fine
>> with it, but clean it up anyway:
>>

>> @@ -4396,7 +4395,8 @@ int main(int argc, char **argv, char **envp)
>>                             NULL, NULL);
>>       }
>>       if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
>> -                          &machine_class->block_default_type, NULL)) {
>> +                          &machine_class->block_default_type, &error_fatal)) {
>> +        /* We printed help */
>>           exit(1);
>>       }
> 
> I thought you wanted it to become an exit(0)?  I don't care either way,
> though, so:
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>

I _do_ care. Printing help isn't an error, so it shouldn't result in a 
non-zero exit status.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
