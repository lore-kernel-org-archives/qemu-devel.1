Received: from eggs.gnu.org ([2001:4830:134:3::10]:40723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqZE-0006Az-5z
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:11:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqZB-000279-EP
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:11:44 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fXqZB-00026j-8b
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:11:41 -0400
Received: by mail-qt0-x241.google.com with SMTP id o9-v6so15636629qtp.3
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:11:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180626151038.24771-1-sameeh@daynix.com>
	<20180626151038.24771-2-sameeh@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f1e2bb36-2be0-ea46-3aff-471a0f527bc1@amsat.org>
Date: Tue, 26 Jun 2018 13:11:35 -0300
MIME-Version: 1.0
In-Reply-To: <20180626151038.24771-2-sameeh@daynix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/2] qga-win: prevent crash when executing
 fsinfo command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: qemu-devel@nongnu.org, Yan Vugenfirer <yan@daynix.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 06/26/2018 12:10 PM, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
> 
> The fsinfo command is currently implemented for Windows only and it's disk
> parameter can be enabled by adding the define "CONFIG_QGA_NTDDSCSI" to the qga
> code. When enabled and executed the qemu-ga crashed with the following message:
> 
> ------------------------------------------------
> File qapi/qapi-visit-core.c, Line 49
> 
> Expression: !(v->type & VISITOR_OUTPUT) || *obj)
> ------------------------------------------------

Due to these multiple lines starting with '---', this patch confuses
Thunderbird + colorediffs extension in a funny way...

> 
> After some digging, turns out that the GuestPCIAddress is null and the
> qapi visitor doesn't like that, so we can always allocate it instead and
> initiate all it's members to -1.
> 
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qga/commands-win32.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> index 2d48394748..c5f1c884e1 100644
> --- a/qga/commands-win32.c
> +++ b/qga/commands-win32.c
> @@ -485,6 +485,11 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
>      char *buffer = NULL;
>      GuestPCIAddress *pci = NULL;
>      char *name = g_strdup(&guid[4]);
> +    pci = g_malloc0(sizeof(*pci));
> +    pci->domain = -1;
> +    pci->slot = -1;
> +    pci->function = -1;
> +    pci->bus = -1;
>  
>      if (!QueryDosDevice(name, dev_name, ARRAY_SIZE(dev_name))) {
>          error_setg_win32(errp, GetLastError(), "failed to get dos device name");
> @@ -556,7 +561,6 @@ static GuestPCIAddress *get_pci_info(char *guid, Error **errp)
>  
>          func = addr & 0x0000FFFF;
>          dev = (addr >> 16) & 0x0000FFFF;
> -        pci = g_malloc0(sizeof(*pci));
>          pci->domain = dev;
>          pci->slot = slot;
>          pci->function = func;
> 
