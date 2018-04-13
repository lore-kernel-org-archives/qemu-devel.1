Received: from eggs.gnu.org ([2001:4830:134:3::10]:32916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6tYH-00078q-RM
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 03:55:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f6tYC-00081W-MY
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 03:55:21 -0400
References: <1523372486-13190-1-git-send-email-walling@linux.ibm.com>
	<1523372486-13190-5-git-send-email-walling@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <369a206b-e77f-3568-a01c-d25789d2810d@redhat.com>
Date: Fri, 13 Apr 2018 09:55:03 +0200
MIME-Version: 1.0
In-Reply-To: <1523372486-13190-5-git-send-email-walling@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] pc-bios/s390-ccw: fix non-sequential
 boot entries (enum)
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
> for this issue for the s390 enumerated boot menu. Since we
> can no longer print a range of available entries to the
> user, we have to present a list of each available entry.
> 
> An example of this menu:
> 
>   s390-ccw Enumerated Boot Menu.
> 
>    [0] default
> 
>    [1]
>    [2]
>    [7]
>    [8]
>    [9]
>   [11]
>   [12]
> 
>   Please choose:
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>
> Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/bootmap.c  | 12 +++++++-----
>  pc-bios/s390-ccw/menu.c     | 29 ++++++++++++++++++++---------
>  pc-bios/s390-ccw/s390-ccw.h |  2 +-
>  3 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/pc-bios/s390-ccw/bootmap.c b/pc-bios/s390-ccw/bootmap.c
> index 2f79346..f9a2fb3 100644
> --- a/pc-bios/s390-ccw/bootmap.c
> +++ b/pc-bios/s390-ccw/bootmap.c
> @@ -558,6 +558,8 @@ static void ipl_scsi(void)
>      int program_table_entries = 0;
>      BootMapTable *prog_table = (void *)sec;
>      unsigned int loadparm = get_loadparm_index();
> +    bool valid_entries[MAX_BOOT_ENTRIES] = {false};
> +    size_t i;
>  
>      /* Grab the MBR */
>      memset(sec, FREE_SPACE_FILLER, sizeof(sec));
> @@ -578,18 +580,18 @@ static void ipl_scsi(void)
>      read_block(mbr->pt.blockno, sec, "Error reading Program Table");
>      IPL_assert(magic_match(sec, ZIPL_MAGIC), "No zIPL magic in PT");
>  
> -    while (program_table_entries < MAX_BOOT_ENTRIES) {
> -        if (!prog_table->entry[program_table_entries].scsi.blockno) {
> -            break;
> +    for (i = 0; i < MAX_BOOT_ENTRIES; i++) {
> +        if (prog_table->entry[i].scsi.blockno) {
> +            valid_entries[i] = true;
> +            program_table_entries++;
>          }
> -        program_table_entries++;
>      }
>  
>      debug_print_int("program table entries", program_table_entries);
>      IPL_assert(program_table_entries != 0, "Empty Program Table");
>  
>      if (menu_is_enabled_enum()) {
> -        loadparm = menu_get_enum_boot_index(program_table_entries);
> +        loadparm = menu_get_enum_boot_index(valid_entries);
>      }
>  
>      debug_print_int("loadparm", loadparm);
> diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
> index 083405f..2f11a51 100644
> --- a/pc-bios/s390-ccw/menu.c
> +++ b/pc-bios/s390-ccw/menu.c
> @@ -225,19 +225,30 @@ int menu_get_zipl_boot_index(const char *menu_data)
>      return get_boot_index(valid_entries);
>  }
>  
> -
> -int menu_get_enum_boot_index(int entries)
> +int menu_get_enum_boot_index(bool *valid_entries)
>  {
> -    char tmp[4];
> +    char tmp[3];
> +    int i;
>  
> -    sclp_print("s390x Enumerated Boot Menu.\n\n");
> +    sclp_print("s390-ccw Enumerated Boot Menu.\n\n");
>  
> -    sclp_print(uitoa(entries, tmp, sizeof(tmp)));
> -    sclp_print(" entries detected. Select from boot index 0 to ");
> -    sclp_print(uitoa(entries - 1, tmp, sizeof(tmp)));
> -    sclp_print(".\n\n");
> +    for (i = 0; i < MAX_BOOT_ENTRIES; i++) {
> +        if (valid_entries[i]) {
> +            if (i < 10) {
> +                sclp_print(" ");
> +            }
> +            sclp_print("[");
> +            sclp_print(uitoa(i, tmp, sizeof(tmp)));
> +            sclp_print("]");
> +            if (i == 0) {
> +                sclp_print(" default\n");
> +            }
> +            sclp_print("\n");
> +        }
> +    }
>  
> -    return get_boot_index(entries);
> +    sclp_print("\n");
> +    return get_boot_index(valid_entries);
>  }
>  
>  void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout)
> diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
> index 2c9e601..a1bdb4c 100644
> --- a/pc-bios/s390-ccw/s390-ccw.h
> +++ b/pc-bios/s390-ccw/s390-ccw.h
> @@ -91,7 +91,7 @@ void zipl_load(void);
>  void menu_set_parms(uint8_t boot_menu_flag, uint32_t boot_menu_timeout);
>  int menu_get_zipl_boot_index(const char *menu_data);
>  bool menu_is_enabled_zipl(void);
> -int menu_get_enum_boot_index(int entries);
> +int menu_get_enum_boot_index(bool *valid_entries);
>  bool menu_is_enabled_enum(void);
>  
>  #define MAX_BOOT_ENTRIES  31
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
