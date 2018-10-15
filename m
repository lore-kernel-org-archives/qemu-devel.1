Received: from eggs.gnu.org ([2001:4830:134:3::10]:57265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCBVn-0003za-5R
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCBVj-0004K2-19
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:38:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54345)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gCBVi-0004JI-Oy
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:38:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so20470328wma.4
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 15:38:50 -0700 (PDT)
References: <20181015115309.17089-1-armbru@redhat.com>
	<20181015115309.17089-34-armbru@redhat.com>
	<31daa4d5-96bf-ac50-7a3d-e503b13c9872@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eb19a7c5-7d26-a9ea-8992-44c34a16114f@redhat.com>
Date: Tue, 16 Oct 2018 00:38:47 +0200
MIME-Version: 1.0
In-Reply-To: <31daa4d5-96bf-ac50-7a3d-e503b13c9872@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 15/10/2018 16:48, Max Reitz wrote:
> On 15.10.18 13:53, Markus Armbruster wrote:
>> Calling error_report() from within a function that takes an Error **
>> argument is suspicious.  drive_new() calls error_report() even though
>> it can run within drive_init_func(), which takes an Error ** argument.
>> drive_init_func()'s caller main(), via qemu_opts_foreach(), is fine
>> with it, but clean it up anyway:
>>
>> * Convert drive_new() to Error
>>
>> * Update add_init_drive() to report the error received from
>>   drive_new()
>>
>> * Make main() pass &error_fatal through qemu_opts_foreach(),
>>   drive_init_func() to drive_new()
>>
>> * Make default_drive() pass &error_abort through qemu_opts_foreach(),
>>   drive_init_func() to drive_new()
>>
>> Cc: Kevin Wolf <kwolf@redhat.com>
>> Cc: Max Reitz <mreitz@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  blockdev.c                | 27 ++++++++++++++-------------
>>  device-hotplug.c          |  5 ++++-
>>  include/sysemu/blockdev.h |  3 ++-
>>  vl.c                      |  8 ++++----
>>  4 files changed, 24 insertions(+), 19 deletions(-)
> 
> [...]
> 
>> diff --git a/vl.c b/vl.c
>> index 65366b961e..22beca29d1 100644
>> --- a/vl.c
>> +++ b/vl.c
> 
> [...]
>> @@ -4396,7 +4395,8 @@ int main(int argc, char **argv, char **envp)
>>                            NULL, NULL);
>>      }
>>      if (qemu_opts_foreach(qemu_find_opts("drive"), drive_init_func,
>> -                          &machine_class->block_default_type, NULL)) {
>> +                          &machine_class->block_default_type, &error_fatal)) {
>> +        /* We printed help */
>>          exit(1);
>>      }
> 
> I thought you wanted it to become an exit(0)?  I don't care either way,

Markus did it in the next patch ;)

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> though, so:
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
