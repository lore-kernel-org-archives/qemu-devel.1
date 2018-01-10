Received: from eggs.gnu.org ([2001:4830:134:3::10]:48062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZJ1v-0005pc-6h
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZJ1r-0003MB-1t
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:15:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eZJ1q-0003LP-P5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 11:15:02 -0500
Date: Wed, 10 Jan 2018 16:14:53 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180110161453.GM3205@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171227011428.40996-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171227011428.40996-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] Add ability for user to specify mouse
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
Cc: peter.maydell@linaro.org, kraxel@redhat.com, qemu-devel@nongnu.org

On Tue, Dec 26, 2017 at 08:14:28PM -0500, John Arbuckle wrote:
> Currently the ungrab keys for the Cocoa and GTK interface are Control-Alt-g.
> This combination may not be very fun for the user to have to enter, so we
> now enable the user to specify their own key(s) as the ungrab key(s). The
> list of keys that can be used is found in the file qapi/ui.json under QKeyCode.
> The max number of keys that can be used is three. The original ungrab keys
> still remain usable because there is a real risk of the user forgetting 
> the keys he or she specified as the ungrab keys. They remain as a plan B
> if plan A is forgotten.

This is a bad idea. A key reason to give a custom ungrab sequence, is because
the user wants to be able to use the default ungrab sequence inside the
guest. Always having the default ungrab sequence active prevents this.

> Syntax: -ungrab <key-key-key>
> 
> Example usage:  -ungrab home
> 	        -ungrab shift-ctrl
> 		-ungrab ctrl-x
> 		-ungrab pgup-pgdn
> 		-ungrab kp_5-kp_6
> 		-ungrab kp_4-kp_5-kp_6

I'm in two minds about using '-' as a separator.  Perhaps '+' is a better
choice ?

> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v4 changes:
> - Removed initialization code for key_value_array.
> - Added void keyword to console_ungrab_key_sequence(),
>   and console_ungrab_key_string() functions.
> 
> v3 changes:
> - Added the ability for any "sendkey supported" key to be used.
> - Added ability for one to three key sequences to be used.
> 
> v2 changes:
> - Removed the "int i" code from the for loops. 
> 
>  include/ui/console.h |  6 ++++++
>  qemu-options.hx      |  2 ++
>  ui/cocoa.m           | 48 +++++++++++++++++++++++++++++++++++++++--
>  ui/console.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  vl.c                 |  3 +++
>  5 files changed, 117 insertions(+), 2 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 580dfc57ee..37dc150268 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -534,4 +534,10 @@ static inline void early_gtk_display_init(int opengl)
>  /* egl-headless.c */
>  void egl_headless_init(void);
>  
> +/* console.c */
> +void set_ungrab_seq(const char *new_seq);
> +int *console_ungrab_key_sequence(void);
> +const char *console_ungrab_key_string(void);
> +int console_ungrab_sequence_length(void);

We don't need to have a console_ungrab_sequence_length() method if
we make the array returned by console_ungrab_key_sequence() be a
zero terminated array.

> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index 330ccebf90..412a5fc02d 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -303,6 +303,7 @@ - (float) cdx;
>  - (float) cdy;
>  - (QEMUScreen) gscreen;
>  - (void) raiseAllKeys;
> +- (bool) user_ungrab_seq;
>  @end
>  
>  QemuCocoaView *cocoaView;
> @@ -674,9 +675,24 @@ - (void) handleEvent:(NSEvent *)event
>                  }
>              }
>  
> +            /*
> +             * This code has to be here because the user might use a modifier
> +             * key like shift as an ungrab key.
> +             */
> +            if ([self user_ungrab_seq] == true) {
> +                [self ungrabMouse];
> +                return;
> +            }
>              break;
>          case NSEventTypeKeyDown:
>              keycode = cocoa_keycode_to_qemu([event keyCode]);
> +            [self toggleModifier: keycode];
> +
> +            // If the user is issuing the custom ungrab key sequence
> +            if ([self user_ungrab_seq] == true) {
> +                [self ungrabMouse];
> +                return;
> +            }

There's a small benefit to only processing the grab sequence in the
Up event, rather than Down event if we are clever with tracking
the key sequence.

Check if each press as it comes in. If it is part of the ungrab
sequence, then record that is is pressed. If is is not part of
the ungrab sequence, the clear out all previously pressed keys.
Only trigger ungrab upon key release

This means that you can use Ctrl+Alt  as your ungrab sequence
and still be able to press Ctrl+Alt+F1 and have it go to the
guest without triggering the grab sequence.

ie, in your patch we get

 down(ctrl)
 down(alt)
 ..ungrab activates..

with my suggest we would get

 down(ctrl)
 down(alt)
 up(ctrl)
 up(alt)
 ..ungrab activates..

 down(ctrl)
 down(alt)
 down(f1)
 up(ctrl)
 up(alt)
 up(f1)
 ..no ungrab activates..

to do this I think you need a separate array for tracking the grab
instead of reusing the  toggleModifier() tracking.

>  
>              // forward command key combos to the host UI unless the mouse is grabbed
>              if (!isMouseGrabbed && ([event modifierFlags] & NSEventModifierFlagCommand)) {
> @@ -714,6 +730,7 @@ - (void) handleEvent:(NSEvent *)event
>              break;
>          case NSEventTypeKeyUp:
>              keycode = cocoa_keycode_to_qemu([event keyCode]);
> +            [self toggleModifier: keycode];
>  
>              // don't pass the guest a spurious key-up if we treated this
>              // command-key combo as a host UI action
> @@ -842,10 +859,18 @@ - (void) grabMouse
>      COCOA_DEBUG("QemuCocoaView: grabMouse\n");
>  
>      if (!isFullscreen) {
> +        NSString * message_string;
> +        if (console_ungrab_sequence_length() == 0) {
> +            message_string = [NSString stringWithFormat: @"- (Press ctrl + alt + g to release Mouse"];
> +        } else {
> +            message_string = [NSString stringWithFormat: @"- (Press ctrl + alt + g or %s to release Mouse", console_ungrab_key_string()];
> +        }
> +
> +
>          if (qemu_name)
> -            [normalWindow setTitle:[NSString stringWithFormat:@"QEMU %s - (Press ctrl + alt + g to release Mouse)", qemu_name]];
> +            [normalWindow setTitle:[NSString stringWithFormat: @"QEMU %s %@", qemu_name, message_string]];
>          else
> -            [normalWindow setTitle:@"QEMU - (Press ctrl + alt + g to release Mouse)"];
> +            [normalWindow setTitle:[NSString stringWithFormat: @"QEMU %@", message_string]];
>      }
>      [self hideCursor];
>      if (!isAbsoluteEnabled) {
> @@ -898,6 +923,25 @@ - (void) raiseAllKeys
>         }
>     }
>  }
> +
> +/* Determines if the user specified ungrab sequence is being used */
> +- (bool) user_ungrab_seq
> +{
> +    int *ungrab_seq, index, length;
> +    bool return_value = true;
> +
> +    ungrab_seq = console_ungrab_key_sequence();
> +    length = console_ungrab_sequence_length();
> +
> +    for (index = 0; index < length; index++) {
> +        if (modifiers_state[ungrab_seq[index]] == NO) {
> +            return_value = false;
> +            break;
> +        }
> +    }
> +    return return_value;
> +}
> +
>  @end
>  
>  
> diff --git a/ui/console.c b/ui/console.c
> index c4c95abed7..895bc3fb17 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -63,6 +63,18 @@ typedef struct QEMUFIFO {
>      int count, wptr, rptr;
>  } QEMUFIFO;
>  
> +/* max number of user specified keys that can be used as the ungrab keys*/
> +static const int max_keys = 3;
> +
> +/* stores the ungrab keys' values */
> +static int key_value_array[max_keys + 1];
> +
> +/* stores the length the user's ungrab sequence */
> +int ungrab_seq_length;
> +
> +/* stores the string that is returned by console_ungrab_key_string */
> +static char *ungrab_key_string;
> +
>  static int qemu_fifo_write(QEMUFIFO *f, const uint8_t *buf, int len1)
>  {
>      int l, len;
> @@ -2239,4 +2251,52 @@ static void register_types(void)
>      type_register_static(&qemu_console_info);
>  }
>  
> +/* Sets the mouse ungrab key sequence to what the user wants */
> +void set_ungrab_seq(const char *new_seq)
> +{
> +    char *buffer1 = (char *) malloc(strlen(new_seq) * sizeof(char));
> +    char *buffer2 = (char *) malloc(strlen(new_seq) * sizeof(char));
> +    int count = 0;
> +    int key_value;
> +    char *token;
> +    const char *separator = "-";  /* What the user places between keys */
> +
> +    sprintf(buffer1, "%s", new_seq); /* edited by strtok */
> +    sprintf(buffer2, "%s", new_seq); /* used for ungrab_key_string */
> +    ungrab_key_string = buffer2;
> +
> +    token = strtok(buffer1, separator);
> +    while (token != NULL && count < max_keys) {
> +        /* Translate the names into Q_KEY_CODE values */
> +        key_value = index_from_key(token, strlen(token));
> +        if (key_value == Q_KEY_CODE__MAX) {
> +            printf("-ungrab: unknown key: %s\n", token);
> +            exit(EXIT_FAILURE);
> +        }
> +        key_value_array[count] = key_value;
> +
> +        count++;
> +        token = strtok(NULL, separator);
> +    }

Rather than this malloc+sprintf+strtok mix, you can just use the
glib function  g_strsplit() to break it into tokens.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
