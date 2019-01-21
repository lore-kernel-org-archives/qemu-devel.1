Received: from eggs.gnu.org ([209.51.188.92]:55592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJB-0008OL-RI
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glaJ1-0000k5-62
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glaJ0-0000jS-JQ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 09:12:03 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C099488E50
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 14:12:01 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Jan 2019 15:11:47 +0100
Message-Id: <20190121141152.948-2-kraxel@redhat.com>
In-Reply-To: <20190121141152.948-1-kraxel@redhat.com>
References: <20190121141152.948-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/5] ui: install logo icons to
 $prefix/share/icons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

QEMU currently installs logos to $prefix/share/qemu/ which means no GUI
toolkit or applications can find them by default.

The accepted standards for desktop applications declare that application
logos / icons should be installed under $prefix/share/icons, so use this
directory location.

Pre-rendered icons are provided at the standard sizes expected for GUI
applications, along with the scalable SVG, to ensure maximum portability.

The PNGs are rendered from the SVG using inkscape, however, this is not
wired up into the default make rules to avoid requiring inkscape as a
mandatory tool in build systems / developer workstations.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Message-id: 20190110120047.25369-2-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 configure                                          |   2 ++
 Makefile                                           |  13 ++++++++++++-
 ui/gtk.c                                           |  17 +++++----------=
--
 ui/sdl2.c                                          |  16 ++++++---------=
-
 pc-bios/qemu-icon.bmp                              | Bin 630 -> 0 bytes
 ui/icons/Makefile                                  |  13 +++++++++++++
 pc-bios/qemu_logo_no_text.svg =3D> ui/icons/qemu.svg |   0
 ui/icons/qemu_128x128.png                          | Bin 0 -> 8286 bytes
 ui/icons/qemu_16x16.png                            | Bin 0 -> 765 bytes
 ui/icons/qemu_24x24.png                            | Bin 0 -> 1201 bytes
 ui/icons/qemu_256x256.png                          | Bin 0 -> 17572 byte=
s
 ui/icons/qemu_32x32.bmp                            | Bin 0 -> 4234 bytes
 ui/icons/qemu_32x32.png                            | Bin 0 -> 1696 bytes
 ui/icons/qemu_48x48.png                            | Bin 0 -> 2694 bytes
 ui/icons/qemu_512x512.png                          | Bin 0 -> 38007 byte=
s
 ui/icons/qemu_64x64.png                            | Bin 0 -> 3807 bytes
 16 files changed, 38 insertions(+), 23 deletions(-)
 delete mode 100644 pc-bios/qemu-icon.bmp
 create mode 100644 ui/icons/Makefile
 rename pc-bios/qemu_logo_no_text.svg =3D> ui/icons/qemu.svg (100%)
 create mode 100644 ui/icons/qemu_128x128.png
 create mode 100644 ui/icons/qemu_16x16.png
 create mode 100644 ui/icons/qemu_24x24.png
 create mode 100644 ui/icons/qemu_256x256.png
 create mode 100644 ui/icons/qemu_32x32.bmp
 create mode 100644 ui/icons/qemu_32x32.png
 create mode 100644 ui/icons/qemu_48x48.png
 create mode 100644 ui/icons/qemu_512x512.png
 create mode 100644 ui/icons/qemu_64x64.png

diff --git a/configure b/configure
index 3eee3fcf70..ce54cd2bdc 100755
--- a/configure
+++ b/configure
@@ -5745,6 +5745,7 @@ qemu_confdir=3D$sysconfdir$confsuffix
 qemu_moddir=3D$libdir$confsuffix
 qemu_datadir=3D$datadir$confsuffix
 qemu_localedir=3D"$datadir/locale"
+qemu_icondir=3D"$datadir/icons"
=20
 # We can only support ivshmem if we have eventfd
 if [ "$eventfd" =3D "yes" ]; then
@@ -6210,6 +6211,7 @@ if test "$mingw32" =3D "no" ; then
 fi
 echo "qemu_helperdir=3D$libexecdir" >> $config_host_mak
 echo "qemu_localedir=3D$qemu_localedir" >> $config_host_mak
+echo "qemu_icondir=3D$qemu_icondir" >> $config_host_mak
 echo "libs_softmmu=3D$libs_softmmu" >> $config_host_mak
 echo "GIT=3D$git" >> $config_host_mak
 echo "GIT_SUBMODULES=3D$git_submodules" >> $config_host_mak
diff --git a/Makefile b/Makefile
index dccba1dca2..e4218d1192 100644
--- a/Makefile
+++ b/Makefile
@@ -667,7 +667,6 @@ pxe-pcnet.rom pxe-rtl8139.rom pxe-virtio.rom \
 efi-e1000.rom efi-eepro100.rom efi-ne2k_pci.rom \
 efi-pcnet.rom efi-rtl8139.rom efi-virtio.rom \
 efi-e1000e.rom efi-vmxnet3.rom \
-qemu-icon.bmp qemu_logo_no_text.svg \
 bamboo.dtb canyonlands.dtb petalogix-s3adsp1800.dtb petalogix-ml605.dtb =
\
 multiboot.bin linuxboot.bin linuxboot_dma.bin kvmvapic.bin \
 s390-ccw.img s390-netboot.img \
@@ -720,6 +719,7 @@ ifneq (,$(findstring qemu-ga,$(TOOLS)))
 endif
 endif
=20
+ICON_SIZES=3D16x16 24x24 32x32 48x48 64x64 128x128 256x256 512x512
=20
 install: all $(if $(BUILD_DOCS),install-doc) install-datadir install-loc=
alstatedir
 ifneq ($(TOOLS),)
@@ -741,6 +741,17 @@ ifneq ($(BLOBS),)
 		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
 	done
 endif
+	for s in $(ICON_SIZES); do \
+		mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps"; \
+		$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_$${s}.png \
+			"$(DESTDIR)/$(qemu_icondir)/hicolor/$${s}/apps/qemu.png"; \
+	done; \
+	mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps"; \
+	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu_32x32.bmp \
+		"$(DESTDIR)/$(qemu_icondir)/hicolor/32x32/apps/qemu.bmp"; \
+	mkdir -p "$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps"; \
+	$(INSTALL_DATA) $(SRC_PATH)/ui/icons/qemu.svg \
+		"$(DESTDIR)/$(qemu_icondir)/hicolor/scalable/apps/qemu.svg"
 ifdef CONFIG_GTK
 	$(MAKE) -C po $@
 endif
diff --git a/ui/gtk.c b/ui/gtk.c
index 579990b865..ec63befa16 100644
--- a/ui/gtk.c
+++ b/ui/gtk.c
@@ -2214,8 +2214,8 @@ static void gtk_display_init(DisplayState *ds, Disp=
layOptions *opts)
     VirtualConsole *vc;
=20
     GtkDisplayState *s =3D g_malloc0(sizeof(*s));
-    char *filename;
     GdkDisplay *window_display;
+    GtkIconTheme *theme;
=20
     if (!gtkinit) {
         fprintf(stderr, "gtk initialization failed\n");
@@ -2224,6 +2224,9 @@ static void gtk_display_init(DisplayState *ds, Disp=
layOptions *opts)
     assert(opts->type =3D=3D DISPLAY_TYPE_GTK);
     s->opts =3D opts;
=20
+    theme =3D gtk_icon_theme_get_default();
+    gtk_icon_theme_prepend_search_path(theme, CONFIG_QEMU_ICONDIR);
+
     s->window =3D gtk_window_new(GTK_WINDOW_TOPLEVEL);
     s->vbox =3D gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
     s->notebook =3D gtk_notebook_new();
@@ -2248,17 +2251,7 @@ static void gtk_display_init(DisplayState *ds, Dis=
playOptions *opts)
     qemu_add_mouse_mode_change_notifier(&s->mouse_mode_notifier);
     qemu_add_vm_change_state_handler(gd_change_runstate, s);
=20
-    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, "qemu_logo_no_text.=
svg");
-    if (filename) {
-        GError *error =3D NULL;
-        GdkPixbuf *pixbuf =3D gdk_pixbuf_new_from_file(filename, &error)=
;
-        if (pixbuf) {
-            gtk_window_set_icon(GTK_WINDOW(s->window), pixbuf);
-        } else {
-            g_error_free(error);
-        }
-        g_free(filename);
-    }
+    gtk_window_set_icon_name(GTK_WINDOW(s->window), "qemu");
=20
     gd_create_menus(s);
=20
diff --git a/ui/sdl2.c b/ui/sdl2.c
index a10b6e3a08..4c0d5db473 100644
--- a/ui/sdl2.c
+++ b/ui/sdl2.c
@@ -762,7 +762,6 @@ static void sdl2_display_early_init(DisplayOptions *o=
)
 static void sdl2_display_init(DisplayState *ds, DisplayOptions *o)
 {
     uint8_t data =3D 0;
-    char *filename;
     int i;
     SDL_SysWMinfo info;
=20
@@ -837,15 +836,12 @@ static void sdl2_display_init(DisplayState *ds, Dis=
playOptions *o)
     }
=20
     /* Load a 32x32x4 image. White pixels are transparent. */
-    filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, "qemu-icon.bmp");
-    if (filename) {
-        SDL_Surface *image =3D SDL_LoadBMP(filename);
-        if (image) {
-            uint32_t colorkey =3D SDL_MapRGB(image->format, 255, 255, 25=
5);
-            SDL_SetColorKey(image, SDL_TRUE, colorkey);
-            SDL_SetWindowIcon(sdl2_console[0].real_window, image);
-        }
-        g_free(filename);
+    SDL_Surface *image =3D SDL_LoadBMP(CONFIG_QEMU_ICONDIR
+                                     "/hicolor/32x32/apps/qemu.bmp");
+    if (image) {
+        uint32_t colorkey =3D SDL_MapRGB(image->format, 255, 255, 255);
+        SDL_SetColorKey(image, SDL_TRUE, colorkey);
+        SDL_SetWindowIcon(sdl2_console[0].real_window, image);
     }
=20
     gui_grab =3D 0;
diff --git a/pc-bios/qemu-icon.bmp b/pc-bios/qemu-icon.bmp
deleted file mode 100644
index 72d9a2f561ecbb61e49e75540debf189ee67cdb5..0000000000000000000000000=
000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 630
zcmZ|ML1@!Z7zgmL>6nKq_KmVSmti*)gn{m0yeXRmMqy5|CLRZ(xt6igC%FvW!4&jR
z5Y{I>2opv>2uSg!3<82qBHKlfV8S|jvNTZCfv5Vts7F6|kN5k(@FnECcD<@VQdQc|
z(<=3DO3DHx&C|Ld*y3DW5_OkcbU<?05Un12uB_kV$Dn(+PS5e$bzn4F%4(b1F8>2yF<
zRmf(uu(IKUNUF)$t`Iq0pO9?i4*)W&wHE+I>C^P;Hb9rc8u6q2k~z7-F=3DBn64w;*Y
zQ{*uKW#-(i85y*MXdZy_Cf2U@+J&Uub5M5TZ^o4<rj}oXn1|Uo{A{>kNWq9`>=3DOgc
zKn$Z^Aya#%?DT^zql7YOLvb_H4^c~uVXx47bRk4Etvj3}y3woSV{w3*B~3win40Vd
zbZrs2jc)Jka)?`&W$C(nz>Qun2e_7)5*wrLRDkQ`A37Dsusem@()Xkn(d|6N?Hgok
zz$mcYubapdmj^7T+t{ijKO^rgYiL}uvDmOH?2k*@ZH~JlUtvcS7%S9*zZBvzXXE73
z<pE>-0sSw|_Q;2(>g6~MMdTMe*`VzE`BkE*SA1$vR()@ALR!3A+8Z**adJxuX^y8z
Z&cg*cELjbvI!`?IkCZfh^+R$cegj&c0K5PI

diff --git a/ui/icons/Makefile b/ui/icons/Makefile
new file mode 100644
index 0000000000..20bd64ccce
--- /dev/null
+++ b/ui/icons/Makefile
@@ -0,0 +1,13 @@
+
+# Regenerate bitmaps from the SVG using inkscape CLI export
+# and ImageMagick. Don't use ImageMagick for the initial
+# SVG conversion, since it merely calls inkscape, but uses
+# 96 DPI res resulting in poor quality output.
+
+regenerate:
+	for s in 16 24 32 48 64 128 256 512; \
+	do \
+	    inkscape --without-gui --export-png=3Dqemu_$${s}x$${s}.png \
+		--export-width=3D$$s --export-height=3D$$s qemu.svg ; \
+	done
+	convert qemu_32x32.png qemu_32x32.bmp
diff --git a/pc-bios/qemu_logo_no_text.svg b/ui/icons/qemu.svg
similarity index 100%
rename from pc-bios/qemu_logo_no_text.svg
rename to ui/icons/qemu.svg
diff --git a/ui/icons/qemu_128x128.png b/ui/icons/qemu_128x128.png
new file mode 100644
index 0000000000000000000000000000000000000000..96831807ba873c9257c1985f4=
3c7618df9128286
GIT binary patch
literal 8286
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
x
z&ZDBDfA2((RXC!uZ?`Dx-zz#BFOY_GS7nA_h@h$fVCmAOMeEkBOQupO@V3vUVMbK{
zNREbKt_)C&Y4DwINgKxiix)3e?z-zP)$JwO8^3hm04Kfk=3D%niXc2xB56Y6juo%Lr+
zuio#&=3Do#0RmzRsm%1W_m(<ZwraFPghn4_m_$-zYoY>7KS!F2UjdC&+U1glrCj@c$l
z0N@t<nf=3Dl4g^>1HSNX%!``{0I;J^@66v6x{u&NO*X@nAwF4ENcjM7!NL>_K9&$Qlx
zc><m^mtJ~l$=3DbDRlY95>)iE18P49Gm9`IA(HnL=3DbTqM8`fUj68gwy%Tl`EC2uDZ&#
z_uJEol1Ev(_5UbJfn2`(Hp4ewhi%=3D^Ism)+;LT2Wss(=3Dakr^O7qZU+`IViP<-%$?E
zy1+=3DO6@DH;Addl{zP?_0`Q?{W&UYM#6ESB&zmm=3DKXUhPWV$N(yH?|`KD2gKPyYIfD
z^73*=3Dz3;>jC+zv7n9;ShV7mXB=3DOE=3DGYz9*BTsypQ0Irw=3DQ;NpZ#Ec|m@lN*FpXaC=
w
zEQjz@327#2XlPL0fB${Gv$NCBAWY*d%+bUT!#;mDbE}##MZa$&EnmJ|sjaOQx~}7Q
zXqqNS#+kqOF9kLHPMGRXv#AqSJPrLWbA0PNHYvsNF30B_)$`IY4C(glPWe|}d8Ku<
zD#$zed*Gx1bQuWC04nfH%z%$CF1h5An5Jn2Jx<yE8&R5!#JvrS|9uX`0=3D(YcN8zU~
z{YxOJ>e(Tz&!X$P)OB5YJ+Bwd(xpq)+S*#D_HmN}6`1xwY2b$^ybAcA9E<OJil(Nf
zCUMhEH>p<f?j`;jy5AMcT7F${%m2iw@QE4l=3DlziIF{5Tzz%}!n^MsycPwjFUMC1qX
z5G0sW(6?{jo;HTu-nSJsn2hjp(B}^$0WJXkdr;z0pWj#X>$*<aPzNh^JgNwpmjN$d
zTs9lt{Vd#mvb)t^tiUY`-OFg|en*+n{hn|W=3D{9xeDG}0i%a<=3D#@fZJg#`r4cwE92@
zDgjhXe}9I@jWf<~yzxf0va-^x*Jq@kdT^aGtAEFY27RWLz*TeM){|gq4K$R)tO_{2
z8ZK>upRIu9GrY@a?0#42DxWKl7T35Lgr0_?T`H87m5I%pH){g}16KDBhjTlYV$Lk`
z^`(Qx0qz1$2}sMdY12eQLxbYv``aO;!3mvjOqz(_%yPJSfq8^Qi5};Yo&Tu5*KnEs
z{;bRNq%v+O+3L$5OZ12zELpNdJ$Ue-)9NF)as{vuGdA#3zd8qz0FA(}Fr$7!ToQ4{
z8D}V`pMJVm*mo?wvHt_Hxck+DGr-$NU|1Ja76mf`gF+ygIq<Qv=3D<uttlH^ea)TzXk
zifp5WQcB62Z@#Hz+`|7H;B4SO@EJZ1A^{%4eYv$G8XFshrfFk=3D4KJL~vw1>#|MX(`
z_g2Z)Zs>@cv4A<1FmDRXodWYJ&EL6|-qAoel<Gq)>3lx6r1SY$Pf3Gpty*I2u3D-e
zDQmL66yehQ$I=3D=3Da8q#)}TU5{q0w}{=3Db8x#?J^dJ973OMOYsGvUtiHZp=3D(_I30A_}=
i
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
S
zxmf&uwAnBQ08h1$eCa@@xUVlmQI08(u<o4`f?n@MlZ`r1ft!42#t^00I{;jTw>rqh
z?F;G#29gHf+?Y9|xJZGzvQW#$a*YW%)!#2KsPwyqfNdMK-s=3DNC$M}V&`Ly`Myr{AC
z?LFwf*qIp{Xey7~1$09;wm=3Dxn0agYf%!lC<2fhOQ(UzWXCJ1Z?q|?8%nc>63#|*;8
zikz2^`ym%wATP#XzAWDqa2N0>?hRkap6>+NpTu}@%dvTcvobw_DC_`xIYH>$^1`NF
zN&sUp$`vwpNMHkIWa?8ug(a_GzQ14EyWMCr%MoYQq3-BIf4)7MEonj`AL<|-8g`rx
zZY9b$Hek9Yn=3DENjN`kOy8R>?EJ2nvS9L8v#GNu9wg=3D}qspwIh7d^&j{7y#f9a0BN2
z^t8^+l?j3}hHttd;ZOTXjWU2W|9G|qBrprO(Ca3JVgNA5sQ&?Tn)%MrG(WcwkNluC
zPITkwpK2jFZ;E4YiNY2LQ$|=3D@zz?3rU?CYGjZMJcV9qukz`Id{Ho6^Qqyd0@=3D^)93
zj-2j4P2Ap?L5`rvhdNk=3D#|OgmX#{$~z}%_w_n2a8A%!&t$E8akp+iDP9*ARjTo)y_
zVp{6?R0j&?-cN5h6;P<ahab)Z?iu~HA}S^boL(A3B*uT&FzWZT1^6N6qRmY}vj=3DTh
zb>Ji+4*_T4FjZ`#B!C@lz;7{EvCJTIcsZ|bpgm6uF0iv<inoD#G1XssxmGErn`}o^
z>HuI0=3D4$WV_Ke9Q0qi&#_&RVcnIE;ZA|KKqXnq(Nn2h}k;5mo<I?TqgelaB<w!jO(
z&31yx$^dE11wM~Cy5$triqsCsfyN03F}GxSit(eQcKix+AT3H;z@DxH%du?|G1(a)
z4Ha{x%hkZ;K$Rsgay!5Sesq19+pzu)cp2}7G*(=3DQsRF%_t1STLnt}giO*mc{z=3D|T^
zT+EktA;*@hMPUa7$+u%Srg(i8Gwhm8C|SWY3}-v!MX3%tfU~jG@pxnaJL)hk+;cGJ
zC!UP?Dcm%ov;&S}eqH5l%*NgfbcLy`2krsxx1~jC2&U6l1MAX>{}~v-2~C)>g*l_g
zEKKiW`sh)Hsa7g6-$8mleLv;`i%!gqvJPXqP#<G9{J34VB18jbY(yn{Tfi;Pn)WiL
cT?N4Z2eYv3cw&<mfB*mh07*qoM6N<$f~zen)Bpeg

literal 0
HcmV?d00001

diff --git a/ui/icons/qemu_16x16.png b/ui/icons/qemu_16x16.png
new file mode 100644
index 0000000000000000000000000000000000000000..ff4f046024ffab8d7c3228caa=
d36c2aafbc52d3d
GIT binary patch
literal 765
zcmV<Z0s{SsP)<h;3K|Lk000e1NJLTq000mG000mO1^@s6AM^iV00004b3#c}2nYxW
zd<bNS00009a7bBm0006Y0006Y0qj=3DtcK`qY8FWQhbW?9;ba!ELWdL_~cP?peYja~^
zaAhuUa%Y?FJQ@H10(wbAK~y-6ZIjDOR8btqKj+@7qt{0!m5gMj(x9egSh!LIb<xUQ
z(xUnUTuZfUS0F@>O%MpR3sj0Su!ls6B@B^7V`2*FOp4-gbsj$Eo^x7suTJHGADq|s
z!|(e$za#j6ob2i8x!Tdu(HRT|4@xQZ{QUgt;NakkiHV8(!1wISX4X7l+xDIQ{{Dy8
zTI{CAtw>Q>fngr1s4-8RK3Ck`-Q6sNxH368c>s71sBAz081C!qyU^8e)U1Ac-LRu!
z3TI!5?eLJuM8;SuYf<$LjaDL&Xo^H4XMm@GGCaVoU@+KTS6640Puv!!y9Iy-?uL_W
zF3*eNPY=3DZ6!h-JV>I#^q*$Uk7GpGmdg+d`KR9<R!t_+z1?EwV!r3O2$%g)lQp{Cy$
zvDG-Aqlru^m1+P+EZ`DgIF3VpER4`<w<rdhJlp0YjdEHZky{&UBAK>SI-LfvfQuH;
z2I$4bMOUrm<xsL$)#u4d1~%$tMjJ{9R|`=3Dh*Vor&GMNMrK$``W11girh;KiBD$ec!
zZbk}JO2u~9T5CNwH>W(Y04gl+IW(ZY{7ShR0>Tq4#bVOQ2mmFeROxhDNh!$!7zPma
zA>+$rddJz)9-t<79mjE$<2X8zNZ^V6A%K_(Q~}N22H{nd0MTBK72igWM)6g8pBNTE
zE$|x11q{FxV7xp}K~*tE?GrZt0VpqApw-|{Z$HjDP#V<bcce;k5S2xcRVP0H9sx6c
zD}V589P<sPU0B(K<AsQ+IC7u#zXGE^KmpHyV&If#g{e5Mor8#`{>s3&Qw<Dc|3(Fj
v0VBXRU<3Kl6bWDk7y^2M7T_?D14MrV2jUu*<^~X}00000NkvXXu0mjf`MOLF

literal 0
HcmV?d00001

diff --git a/ui/icons/qemu_24x24.png b/ui/icons/qemu_24x24.png
new file mode 100644
index 0000000000000000000000000000000000000000..f039c6e25d98844745ef24fd8=
114dde843136a2b
GIT binary patch
literal 1201
zcmV;i1Wx;jP)<h;3K|Lk000e1NJLTq000;O000;W1^@s6;CDUv00004b3#c}2nYxW
zd<bNS00009a7bBm0009p0009p0Rs1fJ^%m!8FWQhbW?9;ba!ELWdL_~cP?peYja~^
zaAhuUa%Y?FJQ@H11TINLK~zYIg_Zw{6m=3DNKU!R$s+jI3+ZPh$e^9y;dQ6Q2KmV}zO
zsRV+B6%zdtMD#;azw{SG!9fvyK@94L2thQ8E}>}ax(LoMb**|`r|03Vp6l*<U!0xY
z*_qGN54&^DuIu%{!)InbpU?aCJkMul9>v_YGLcB^-@SYH!OfdDuZhRw3#-+t<Z`)U
zUtixp>2&%S@I7$te{}A$713z)qr-;}J3~W5elC~OtvsDhyWQR0Mc@dqs+Ex0;@Q4<
zJl=3Dcs=3D+P(lKc2K!op{xV{raI&Bfp@p{zb`gxNXLz>{g|tqeG=3Dqsc0+~+t}aVe*hQ)
zF3kma%`l8ldwP00Hf-2nEIoZhExz)zGAq-x6)&q;_Ox1f;iQTVe5q#4xa6aq;y4b;
zWYTn9w{386a4#?koNEPm8u%=3DgN=3D0|<*kKyQD?B>zzM+tY2=3D@G-I6L8TQ2LB(^VjL3
zii_ho($&>vrqgN9w(adeCdecJbOOCV`=3DLXJEX%UgmdwY-BIlY4i)$2X7YO4e*tWtV
zerrSxM<3GDu1KX)!Eqe9c=3D4hJb^^x$J5t~K4lv&|O=3D7VaGdHuca&oXi9KhE?q8*-D
zrRdKY=3Dt7as8}CM(wz!Nh+3F_}2@_C22k;i~b_93;cmcq&EGZNUl63zyO!4kIeanE2
zivR>yTrN8%x2qLpPZgBPURO&KTfI6!0SAGe2(Sk*04bNtYGPtSwp*8KOIp|r?W85C
z(>&}?x3`O$r$jAO8jz8ZkuV?vbVus-lE5>WjQ`4}e1!J9#lJ1B=3DPP@YUlvo8vIT5W
zN(Flv9v+quKmj`=3Dz?v}N{Q2|#)Y`Z-12Ux!-Wy%6g`%p91|tBrZR>0{tD9n469MiI
z102VZv78nbH?BNWv?O0B2sLHGdpyr$Y-~)6NH}^0bVdLjUJS_iWTiP0JlByz4Itsj
zJ<nrmYD)XQ-@HWuDgsOZ3&Ma;F5o`59&5`Ij9_)bEK?}l0gH&#2Wb|qy8w9u7;VmA
zx{AN+JM4j*%!ajXnJCd(blvL~l<HnKYydwt0W=3D_!E_z=3DtrO_EQz|wiB$Cg2TK3vwh
ztlt1m0bW=3D<xXzW)&z_=3DG@@hiQud978_weRyJm4DxxDI^XEFO%RBL17dQwBJ&4pX%j
zZdIxi!1dr~Hwe50MC<p#K>=3D_kk4`Sa+_s#^@lmQdXEuOV;sQ(qF9WxOx8w%!MyOOl
z7PFbW{u`xy8F^wk<{V`TKtEA?I~)4JC1478syPDy$472ekVo#r?7d30Mf73FYT$FA
z(%jL`0e=3DI#fVNP%YLj{VuEm&t+-S%&3<~ZeKo<D3RZqT5tywGpHo=3D{b4PbN{ZF>#E
zK5!g(5U@g!6~Gtw_$kj?Cy=3D7nPFGXw9VT!KxB&D6CxLO`1K>p(OSShu=3DsGAoz2SZV
P00000NkvXXu0mjft@<L*

literal 0
HcmV?d00001

diff --git a/ui/icons/qemu_256x256.png b/ui/icons/qemu_256x256.png
new file mode 100644
index 0000000000000000000000000000000000000000..a39c0e307e2d8a01f1341a7b3=
dd7308449633e9c
GIT binary patch
literal 17572
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
`W~
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
I
z0n;mq4c3Y2we<5e(%AheZ-V*l{`)yTB@`I@!!Z7>Y=3D^=3D4{d5|C(kDRKP7!C%W>|bY
z#?0(2moo2~w((r*Ha76PM49#|d7r{ywzbRbtmhx0VY@76MyJ(n3%pWXdskOYb0@%O
zwk67y(C3d3BW(JANED=3D<;%KgJZc#8U1ZN9Q3=3D2gJ9*5HJI-z}<!9s@JsqMj?sF^`3
zCQb3{zU5UX(oQJ3wWH&b>uP?6@SFFPU=3D|wKX>55bU-j1YuC=3Du_2F5TUrVIQm`w3qh
z+mJMG(60!mnez7~;T8kQ^?JuWOMib%OAGIsVJ>i4hGmz_HwC$nq%Gf*&a;o`m)S5z
zz4c77=3D1LTNEINASf_xMp(6BnU05hM$kUURdaZbs)$ARuL(>oo#sKej|ZkOZ32WcxS
zD@q!`k1?_sgIzP+AsmRad2!$ur-^7n5|ZzYjT+xqQv7m%Mwe<b{7@2K47K`u@iH8h
zhy>kpT}Rvh<Kt;UC>u`jU%SVuPPnW1)Vo0f>Ip?BQ~`{ugS$A;<e58cm)NRnYS>O(
z_rJQ$50>tVAmP6H)X6-5v!2nlC48F8otwPB&ShSzv#WUxa@7lsa^_Jg>FN^swt+h4
zfKOj21sEpmT)`Qr^SN{Q{Q0xAo}S*2Pw?^HZ@|3juc|x#zjoHVHrSpMxK>rj_CV#*
z+iWHe7^YW8Mk4e6z8RRL>&7cT(-Q+dC1E~=3DN6BnBo^)3-*n3;NC(?^^eUJYGZueG~
zVkh=3Djn!J=3DL1eJCoetfznp=3DQ4EMr(Wf=3DCy}|7QA|zzX@O<I512w_y}5hAjZ17y4nP=
f
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

literal 0
HcmV?d00001

diff --git a/ui/icons/qemu_32x32.bmp b/ui/icons/qemu_32x32.bmp
new file mode 100644
index 0000000000000000000000000000000000000000..c0daa54abeecc4fee14707c83=
a59c2085e2eeebd
GIT binary patch
literal 4234
zcmbW4c~Dhl7{<@ND2re)BAcZ_Dk?T*Zb@l6C}JjPfH|q50^QVq7$;Ll8OA2dC37tY
z*PK!tQJP6jkeC)7Lo%AoFvhW|1eM%b?t1Pyr{}r%etJ0GtL8iYJm1;A=3DY5}VIhVA|
zHBpi$*5LnQkm$pNRuI|}?vLr@g{R)oB+2`ar&?M@_S?&kTl>$h>=3Dl#v{x#E>Aw!~<
zTP(?AESBKiTepUd?D9uYpPB0i`(E}O(B-2>I9{9#nDS9j51PP5a28a6)qu~00TBgg
zTmx5q{EK5V_zOgW2SqF%SPA|Fe2?!F_Q!t7bsaa*ZUi5JC&3RuJg3iL6RzJcf^l;p
zxB#vIq1{opM_P+y?o3U=3DO|%Km`7DnjKj8!O9|{6RG;WlG%fO$uw?C8lhLpC~iD!i7
zEwqU^7kL<SpeKQ10B-yY?x)TEZb~WhtkRTP8Ev6^8*L)a^|^=3D~=3Ds`a47aZ%;;KABq
zvA3mJH&tou7cM+c%@!TTJcJMQjdL~%7$XE14ue42-kQDM-jdSxI3<gwNlzEq@eZ|H
zeHil)UWgp(@LVu32DgDrz&PH_S!lDb+fq`FRkEm>N5A{vc3h)&n-60iVmyRC`+EoI
zBMB$}0M>4t=3DN+}X_G**zZm1sZ8BMArnW)Pg1o}LL7a|AtMSa%EwJBmP8p3z|+UB#&
z+grD}Q;RgE#_iFj_b+VZ*i+Z)BTx=3DPpM9}U&cPLc5dpZj2;ar}?x@W%PTk-gb83_L
z7diGe9r`@z1IL0M_|vB*wI>6i&Dxn8wds|&ZuXHf&wi(FYEQpN@2Slk^m!O_2&B(C
zCx8zD^@Z<3n_e;R7Af&nn^frX)+}lty~B-r)OGmK=3DfNB}7QzF6^;7>na1?OP`SZO+
zdNRu<6*xL-Gl#x2IQHE81k6MD@G$zU_iJzt`1id>TKhe9`|1ykAM6SX3llieCXUe1
zP<v2NkX~Q!znK3VV``oT{8owD#ai?F&b>|eZ8*k0(Z>}R7bp8*+Z7)l?*tBD>(;HC
z)oeD?f1$5m|J0*Czir$P#hkml)-ZQFWmVr@YX<$k{hx6sCntO8*RP)pT)+t&z($gi
zlG@>gQJ-4W=3Da_TPX#l*|q4x0b@b-wAXO%$p4;(dJ89H>Rhhf8p$-o7iz%hLIa67O8
zYf4HAJ>WXhuYJ}|{og<p5OdzM-b^M_>xdB}Y@zvAz5AS@cIK4u`Y~<n*s<!kapM#q
zll1g-Cvf<%jUPYW3fg=3D2>`4#A*bDEu<_?4PzI%7pTTDz$TW)TyJtF^7Kz-(rnD>n~
zDR-7TJ3HH*lau4};pDqMtT<XTGBW4^_4VFUe>KSQ-4lCFYieq$Ek8fs`M9M%p#NfA
zI$P{oN@0~UwP2CVcSu1&fdkkJ3kz+)3fiNhqJ+Nip8I_k=3DnD8fpgw(SMLqTf3l=3Dzs
z%&&f+zR1IDQMA7E&nPd=3DE0agg`dA+LTB$oOYqt`gwNuG>qr};}cOUwz_nvc~`!8cN
z@UA)NGyjs364#8yp9P%%Lie8IoK{WBI-yCUO7VT#q;;9FR~=3DFCxogm%L99<-`$`J?
zq7ROogRH-8&YU@pb?er-R<GSChs<@}yZ4Ftm~Ydh>^jXfsaos&@|RlVD|@xr+^^KA
z*$wJrmaFRXMJL^hSAFW(uwjD@YnA>}pX1KjV}U;SJ@ovJm^g8wef#$9GH?%Dd?DZ*
zG+SiNvp1(7)Xd0%UWCkbX>YFnUf#ZAmviUNosM0*cG<UW+h&i5h!AU@<GxTY>}!YO
zcoMW>{#*C&-|sFfD|2t&eMAYK>kjNe_vi2z5&kObIl=3DSHq!s6t0|ySc4jw${B<1Dh
zj-^YN@>|69&e|&hwfseIT;$&+?L|dJ&dSP4cSS{oGI1rowZe15F*vhAlhVsIsZiEp
zimclHL*L0&RaGtl-gm-#jxF`;fYEnc>JZQ3>~HvGW&JfZHOistIwf%t#@e7Q&Q16&
znELK@^~kq%?o+2u$%5M2T9?IQ;h0kU7cc-kOwfm)5)u+@$BrFy*Vor8(?7YPn%?sM
z?g^QvXeq@uZS<-(b@84nYIW^-<=3DnY*ZX?T<Eu-(8b4NfN_&*Vbhd+pnjBG6}EtMM^
z8`YZMuc#-^Tv3k$o|C4gCdEiYLxX$Tv}s&R{I->V5b&tMwYdd*;>~^g_Q}o7&1y?a
zi(goOadELVIy#!V>%mixD(dGw?vqn7FScZ6X8wwCy}D${l6LHqZFzZlm$AS6i2Kyc
L24Y`B^ZxN4*#rg}

literal 0
HcmV?d00001

diff --git a/ui/icons/qemu_32x32.png b/ui/icons/qemu_32x32.png
new file mode 100644
index 0000000000000000000000000000000000000000..b746096cf8104bccfda8259ee=
2f75de1bab2e0e5
GIT binary patch
literal 1696
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

literal 0
HcmV?d00001

diff --git a/ui/icons/qemu_48x48.png b/ui/icons/qemu_48x48.png
new file mode 100644
index 0000000000000000000000000000000000000000..067281225de66e9b381b23bdd=
6ee905465c625d2
GIT binary patch
literal 2694
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
M
zZ0cPoNX2(t0&-+z#2FnOEs4ixNfkGzmNE%2I-xmb&MVk|(uUOS;!-<IN(6|c(`h+0
zG!zxEVb-7qokU%nv5>ZOAN}Rb%<59ND${=3D6WG0i5<KyE+67wIA!lnWlq7!7{Lc@V0
zquAHAlzk1Qkqkqc5(<=3DnbR5SalgUWSviw0?sf08Y_XVLT;)J4^_|XUCcCM$UE?zo2
zq=3Dbg%5{LpMrIa|1BW>HR6l|D{C_sP60U6fb9mKkIC;D)<^bD<RwlE9>!!TsN`S&pl
z1Jg9I?MhPp6cfI7Rsl|hfQ=3D-y?;_T1JJCi<kXSnhCB$b@nGi8fCBXf5N&)^I1X+fV
zJUoJZ=3DiBI7M5?}V7K*Bb0>4rcK|7!T?*maOGLp=3DmA*}nm(VY+o4RN?>cF}Cfi0yL6
zJPV6C2lyZcXuvvPcEp8Yw+=3DuY8^bXjST}ddyEU2xJI_)|<X1ZThk&QN0`1ih=3DTR~$
z>U-=3DExff0{Wr67Kg~Vc_tSrN%R4K7n;qtP|UvQrXrND;iSpsZ+kL<_e#WI{#i@0UZ
zlx3Ts-%3dY_w^uwG2r(RV8h51?Po0HeY??gtN5CG77+{aIUS%;_B=3D4|Cjjsy?p+9i
zjhuP^{)eO3kL)4mALZ_as7iSmMFEc@m%;rI0u(PTW&j)aTUTV@me?2jhp|^Q6I;>j
z`mK*6{(25;AQL&WVI;~CdklET+X-s)Y21$sB?C9mS9JWrf1vkIUXF)b+9G9C3Vamd
zL-<zZ!U$Nv_khVVpd$fI7&x1ID6D?1o>h`SSTIMC0{96OXS}d1aR%6mE2mO%5VbAe
z9KihZ8F!%1UnUS`(}{=3Dcf(N3~+%DWT$a29OwhbVE@B#WI1KC=3DQXsNpVx){>Jh(yK1
zw}U`S)%M4LbGT3G;CUiqyI^S(X-nko^N7EE8e>q4ELVb7ibM<04P5X#%DtR?1RMvx
z2vk)txbXk}^CH%r?Ib=3DN!}@rvP*#KyE~kJ0Zyb2jJF$|ro?XC~fDe66O2&ZKYzdqG
z&g6pnqH(4xqoCb|?***V57pzqA8|i@u7bkyO4&E$i&>ln^~63JD_Piimcv~!FO_0d
zU<fz>l@kEBeBBTH2^V+=3D6s;49h+mFP1s^0niCYOgfGbz;gL0IV<^sQ+E&<Onz`MBL
z(k=3DkaxTSd1-G~Z!2iSwV&i^p*Hg0Jj$4wlbg^_3hdVuqv%6dQU3ipk;>#R$G_IzJm
ze!wwc0{4#`hx6@UxKapO6K=3DfulSY`NUIQNbFPB3JFQGKfCjbBd07*qoM6N<$f&ds3
AvH$=3D8

literal 0
HcmV?d00001

diff --git a/ui/icons/qemu_512x512.png b/ui/icons/qemu_512x512.png
new file mode 100644
index 0000000000000000000000000000000000000000..86aaa6395fc91271562db2b07=
5ddd8e889531680
GIT binary patch
literal 38007
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
r
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
L
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
T
zEC&+3IKcnakWaI$RSOaS>|V>VGuMj<Jar-z5ioV~`!mr8(?aDigcm_H2w6>I-w7j<
z5ld5nsd=3D^NpR4)f{Ij)OO?yS}`xK`&vdAbDwOhBfZ{kKvp`{ClK65p+W~Ycf3@^H_
znHHBdLFjgVPDM!85xNoTZjUC+(PC{;k@l8#BOP=3DGHB|>ftk&FAlnc%dytliKu30N$
z6Wf~~pfZNfL^4OaMr-lJ#+ykBX4Wd}TsPFcZ@@d%^x2(9T!R~|2JK-r!7RL&(!DgY
z{el!Jla;S-*=3DctG@e@pOqrn?Dy5Ur!rBH0q8=3D6KA5!JV$a5n0Vd-(^@LJpz)s0Yiq
zTqJdj>pR++lcUQ~`{+>}69bKbCS*73GVh2BkmN-~d#S&N&E{}X>lV@|OI8!VPVna_
zlA3{W)rEiccF%${j^6}+0nNKifG}*53K=3De+?4}F%&L%-$SYNY7t3P)1F8g+-Km}-%
z=3DG{=3Dnx!e@DBmWdkw9WU#=3DRF(t^*dJc*W#u)$=3D}kFzODv)tjce%ZQxrL2)4OQA{Q-=
#
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
P00000NkvXXu0mjf?B&HP

literal 0
HcmV?d00001

diff --git a/ui/icons/qemu_64x64.png b/ui/icons/qemu_64x64.png
new file mode 100644
index 0000000000000000000000000000000000000000..e00c8b4c9be88a89b091bb967=
900d18e97d9011b
GIT binary patch
literal 3807
zcmV<54j}P~P)<h;3K|Lk000e1NJLTq002M$002M;1^@s6s%dfF00004b3#c}2nYxW
zd<bNS00009a7bBm000Pq000Pq0U+&X3;+NC8FWQhbW?9;ba!ELWdL_~cP?peYja~^
zaAhuUa%Y?FJQ@H14qQn@K~#90#hZO_6z6@%KhNIY9TEshcS5{KR3P397L<TJrqsk_
zT7$=3D9*G}!W<MQIBosNTN_@hueGyS7YQ`dhmeTk<{8aK%l+PF?Ujvd=3D|2{F{b7&#6g
z3^o=3DB1VUIyLP&Qy-Rbsr_vs&dd)iy=3D-R&LH^f$A!yU(-td-*=3DU-|u-n!SvG{U=3Dy$=
k
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
V>^nknkV*gm002ovPDHLkV1gxkF)RQ8

literal 0
HcmV?d00001

--=20
2.9.3
