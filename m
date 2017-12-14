Received: from eggs.gnu.org ([2001:4830:134:3::10]:39757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePVsM-0000wo-MF
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ePVsK-0000oo-PQ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:56:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ePVsK-0000ng-F1
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:56:44 -0500
Date: Thu, 14 Dec 2017 15:56:35 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171214155635.GA28326@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171214143713.3795-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171214143713.3795-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] Add ability for user to specify mouse
 ungrab key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, kraxel@redhat.com

On Thu, Dec 14, 2017 at 09:37:13AM -0500, John Arbuckle wrote:
> Currently the ungrab keys for the Cocoa and GTK interface are Control-Alt-g.
> This combination may not be very fun for the user to have to enter, so we
> now enable the user to specify their own key as the ungrab key. Since the 
> function keys are the keys that don't tend to be used that often and are
> usually available, they will be the ones the user can pick to be the ungrab
> key.

We shouldn't make such assumptions about the function keys being what
the users wants to use. We should allow any arbitrary combination of
keys to be used. Just generalize the way Control+Alt+g is handled such
that we match an arbitrary sequence instead of the hardcoded sequence.

> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v2 changes:
> - Removed the "int i" code from the for loops. 
> 
>  qemu-options.hx |  2 ++
>  ui/cocoa.m      | 20 ++++++++++++++--
>  vl.c            | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 92 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-options.hx b/qemu-options.hx
> index f11c4ac960..0a727ea50a 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4472,6 +4472,8 @@ contents of @code{iv.b64} to the second secret
>  
>  ETEXI
>  
> +DEF("ungrab", HAS_ARG, QEMU_OPTION_ungrab, \
> +    "-ungrab <key>", QEMU_ARCH_ALL)

Should be '<key sequence>', as we must allow more than one key to
be listed to get a full sequence. eg you should be able to set

  -uncgrab  ctrl+alt+g

to replicate the default behaviour via CLI. For sanity, it is
reasonable to limit the number of keys to max of 3.

> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 330ccebf90..8dc603adf0 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -106,6 +106,9 @@
>  NSTextField *pauseLabel;
>  NSArray * supportedImageFileTypes;
>  
> +int get_ungrab_key_value(void);
> +const char * get_ungrab_key_name(void);

This shouldn't be in cocoa.m - we should have something in common code.
Perhaps declare them in include/ui/console.h. Also give them a 'console_'
prefix in fnuction name.

Since we need a full sequence of keys we would need something more
like

   int *console_ungrab_key_sequence()
   const char *console_ungrab_key_string()

The first returns a 0 terminated array of ints, eg ctrl+alt+g would
be represented as a 4 element array

 { Q_KEY_CODE_CTRL, Q_KEY_CODE_ALT, Q_KEY_CODE_G, 0 }



>  const int mac_to_qkeycode_map[] = {
>      [kVK_ANSI_A] = Q_KEY_CODE_A,
> @@ -678,6 +681,12 @@ - (void) handleEvent:(NSEvent *)event
>          case NSEventTypeKeyDown:
>              keycode = cocoa_keycode_to_qemu([event keyCode]);
>  
> +            // if the user wants to release the mouse grab
> +            if (keycode == get_ungrab_key_value()) {
> +                [self ungrabMouse];
> +                return;
> +            }

This will have to track the sequence of pressed keys across
invokations of handleEvent.

This could be done by simple static variable that tracks the
array index we've matched in the ungrab sequence. eg perhaps

    static size_t ungrab_index;

    int *ungrab_seq = get_ungrab_key_seq()
    if (keycode == ungrab_seq[ungrab_index]) {
        ungrab_index++;
	if (ungrab_seq[ungrab_seq] == 0) {
	     [self ungrabMouse];
	     return;
	}
    } else {
        ungrab_index = 0;
    }

this lets you remove the current code that deals with
ctrl+alt+g ungrab.


> diff --git a/vl.c b/vl.c
> index 1ad1c04637..c2d848fabc 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -185,7 +185,8 @@ bool boot_strict;
>  uint8_t *boot_splash_filedata;
>  size_t boot_splash_filedata_size;
>  uint8_t qemu_extra_params_fw[2];
> -
> +int ungrab_key_value = -1;
> +char *ungrab_key_name;
>  int icount_align_option;
>  
>  /* The bytes in qemu_uuid are in the order specified by RFC4122, _not_ in the
> @@ -3088,6 +3089,73 @@ static void register_global_properties(MachineState *ms)
>      user_register_global_props();
>  }
>  
> +/* Sets the mouse ungrab key to what the user wants */
> +static void set_ungrab_key(const char *new_key)
> +{
> +    const char *keys[] = {
> +        [0 ... 0xff]    = "",
> +        [Q_KEY_CODE_F1] = "f1",
> +        [Q_KEY_CODE_F2] = "f2",
> +        [Q_KEY_CODE_F3] = "f3",
> +        [Q_KEY_CODE_F4] = "f4",
> +        [Q_KEY_CODE_F5] = "f5",
> +        [Q_KEY_CODE_F6] = "f6",
> +        [Q_KEY_CODE_F7] = "f7",
> +        [Q_KEY_CODE_F8] = "f8",
> +        [Q_KEY_CODE_F9] = "f9",
> +        [Q_KEY_CODE_F10] = "f10",
> +        [Q_KEY_CODE_F11] = "f11",
> +        [Q_KEY_CODE_F12] = "f12",
> +        [Q_KEY_CODE_PRINT] = "f13",
> +        [Q_KEY_CODE_SCROLL_LOCK] = "f14",
> +        [Q_KEY_CODE_PAUSE] = "f15",
> +    };

We should just use the existing table generated by qapi.

> +
> +    int key_value = -1;
> +    int i;
> +
> +    /* see if the user's key is recognized */
> +    for (i = 0; i < ARRAY_SIZE(keys); i++) {
> +        if (strcmp(keys[i], new_key) == 0) {
> +            key_value = i;
> +            break;
> +        }
> +    }

And of course we need to cope with a full sequence

> +
> +    /* if the user's key isn't recognized print the usable keys */
> +    if (key_value == -1) {
> +        printf("Unrecognized key: %s\n", new_key);
> +        printf("Usable ungrab keys: ");
> +        for (i = 0; i < ARRAY_SIZE(keys); i++) {
> +            if (strlen(keys[i]) > 0) { /* filters out undefined values */
> +                printf("%s ", keys[i]);
> +            }
> +        }
> +        printf("\n\n");
> +        exit(1);
> +    }

Not sure this is really needed - any valid qemu keycode
should be allowed.

> +
> +    ungrab_key_name = (char *) malloc(4 * sizeof(char));
> +    strncpy(ungrab_key_name, new_key, 3);
> +    ungrab_key_value = key_value;
> +}
> +
> +int get_ungrab_key_value(void);
> +
> +/* Returns the user specified ungrab key's value or -1 if not specified */
> +int get_ungrab_key_value(void)
> +{
> +    return ungrab_key_value;
> +}
> +
> +const char *get_ungrab_key_name(void);
> +
> +/* Returns the name of the user specified ungrab key */
> +const char *get_ungrab_key_name(void)
> +{
> +    return ungrab_key_name;
> +}

Should all be in ui/console.c really, not vl.c

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
