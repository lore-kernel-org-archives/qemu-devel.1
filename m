Received: from eggs.gnu.org ([2001:4830:134:3::10]:36140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFGsW-0006YE-Qw
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gFGsR-0002MM-62
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:59:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45333)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gFGsR-0002LW-01
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 06:59:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id s3-v6so2128132pga.12
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 03:59:02 -0700 (PDT)
References: <20181023213600.364086-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c5ea8c11-9e7e-fa87-e796-f574244364ee@redhat.com>
Date: Wed, 24 Oct 2018 12:58:55 +0200
MIME-Version: 1.0
In-Reply-To: <20181023213600.364086-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vl: Avoid crash when -mon is underspecified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armbru@redhat.com, peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On 23/10/18 23:35, Eric Blake wrote:
> A quick coredump on an incomplete command line:
> ./x86_64-softmmu/qemu-system-x86_64 -mon mode=control,pretty=on
> 
>   #0  0x00007ffff723d9e4 in g_str_hash () at /lib64/libglib-2.0.so.0
>   #1  0x00007ffff723ce38 in g_hash_table_lookup () at /lib64/libglib-2.0.so.0
>   #2  0x0000555555cc0073 in object_class_property_find (klass=0x5555566a94b0, name=0x0, errp=0x0) at qom/object.c:1135
>   #3  0x0000555555cc004b in object_class_property_find (klass=0x5555566a9440, name=0x0, errp=0x0) at qom/object.c:1129
>   #4  0x0000555555cbfe6e in object_property_find (obj=0x5555568348c0, name=0x0, errp=0x0) at qom/object.c:1080
>   #5  0x0000555555cc183d in object_resolve_path_component (parent=0x5555568348c0, part=0x0) at qom/object.c:1762
>   #6  0x0000555555d82071 in qemu_chr_find (name=0x0) at chardev/char.c:802
>   #7  0x00005555559d77cb in mon_init_func (opaque=0x0, opts=0x5555566b65a0, errp=0x0) at vl.c:2291
> 
> Fix it to instead fail gracefully.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   vl.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/vl.c b/vl.c
> index 4e25c78bff0..2ed8672eb79 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -2288,6 +2288,10 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
>       }
> 
>       chardev = qemu_opt_get(opts, "chardev");
> +    if (!chardev) {
> +        error_report("chardev is required");
> +        exit(1);
> +    }
>       chr = qemu_chr_find(chardev);
>       if (chr == NULL) {
>           error_report("chardev \"%s\" not found", chardev);
> 
