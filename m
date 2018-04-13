Received: from eggs.gnu.org ([2001:4830:134:3::10]:55308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6rzL-0003nP-HB
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 02:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6rzI-0006CM-BO
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 02:15:11 -0400
References: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
	<1523372486-13190-4-git-send-email-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7326624e-a5d7-b486-ba76-05da7885fcd9@redhat.com>
Date: Fri, 13 Apr 2018 08:14:47 +0200
MIME-Version: 1.0
In-Reply-To: <1523372486-13190-4-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] pc-bios/s390-ccw: fix non-sequential
 boot entries (eckd)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com
Cc: gor@linux.ibm.com, frankja@linux.ibm.com

On 10.04.2018 17:01, Collin Walling wrote:
> zIPL boot menu entries can be non-sequential. Let's account
> for this issue for the s390 zIPL boot menu. Since this boot
> menu is actually an imitation and is not completely capable
> of everything the real zIPL menu can do, let's also print a
> different banner to the user.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/menu.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index 96eec81..083405f 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -158,7 +158,7 @@ static void boot_menu_prompt(bool retry)
>      }
>  }
>  
> -static int get_boot_index(int entries)
> +static int get_boot_index(bool *valid_entries)
>  {
>      int boot_index;
>      bool retry = false;
> @@ -168,7 +168,8 @@ static int get_boot_index(int entries)
>          boot_menu_prompt(retry);
>          boot_index = get_index();
>          retry = true;
> -    } while (boot_index < 0 || boot_index >= entries);
> +    } while (boot_index < 0 || boot_index >= MAX_BOOT_ENTRIES ||
> +             !valid_entries[boot_index]);
>  
>      sclp_print("\nBooting entry #");
>      sclp_print(uitoa(boot_index, tmp, sizeof(tmp)));
> @@ -176,21 +177,28 @@ static int get_boot_index(int entries)
>      return boot_index;
>  }
>  
> -static void zipl_println(const char *data, size_t len)
> +static void zipl_println(const char *data, size_t len, bool *valid_entries)
>  {
>      char buf[len + 2];
> +    int entry;
>  
>      ebcdic_to_ascii(data, buf, len);
>      buf[len] = '\n';
>      buf[len + 1] = '\0';
>  
>      sclp_print(buf);
> +
> +    entry = buf[0] == ' ' ? atoui(buf + 1) : atoui(buf);
> +    valid_entries[entry] = true;

zipl_println is now doing more than its name suggests - it now also
populates the valid_entries array. So I think you should either put an
explaining comment in front of zipl_println, or (what I'd prefer), move
this valid_entries populating code rather to the while loop in
menu_get_zipl_boot_index below instead.

> +    if (entry == 0)
> +        sclp_print("\n");
>  }
>  
>  int menu_get_zipl_boot_index(const char *menu_data)
>  {
>      size_t len;
> -    int entries;
> +    bool valid_entries[MAX_BOOT_ENTRIES] = {false};
>      uint16_t zipl_flag = *(uint16_t *)(menu_data - ZIPL_FLAG_OFFSET);
>      uint16_t zipl_timeout = *(uint16_t *)(menu_data - ZIPL_TIMEOUT_OFFSET);
>  
> @@ -202,19 +210,19 @@ int menu_get_zipl_boot_index(const char *menu_data)
>          timeout = zipl_timeout * 1000;
>      }
>  
> -    /* Print and count all menu items, including the banner */
> -    for (entries = 0; *menu_data; entries++) {
> +    /* Print banner */
> +    sclp_print("s390-ccw zIPL Boot Menu\n\n");
> +    menu_data += strlen(menu_data) + 1;
> +
> +    /* Print entries */
> +    while (*menu_data) {
>          len = strlen(menu_data);
> -        zipl_println(menu_data, len);
> +        zipl_println(menu_data, len, valid_entries);
>          menu_data += len + 1;
> -
> -        if (entries < 2) {
> -            sclp_print("\n");
> -        }
>      }
>  
>      sclp_print("\n");
> -    return get_boot_index(entries - 1); /* subtract 1 to exclude banner */
> +    return get_boot_index(valid_entries);
>  }

 Thomas
