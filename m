Received: from eggs.gnu.org ([2001:4830:134:3::10]:51786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JT-0003Oq-GE
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JG-0008Is-IG
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:13 -0400
Received: from [185.30.24.106] (port=13508
	helo=hotspot.internet-for-guests.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gF6JE-0008CN-QQ
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 19:42:02 -0400
Date: Tue, 23 Oct 2018 19:41:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181023234112.188140-21-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 20/28] tests/bios-tables-test: add 64-bit PCI
 MMIO aperture round-up test on Q35
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>

From: Laszlo Ersek <lersek@redhat.com>

In commit 9fa99d2519cb ("hw/pci-host: Fix x86 Host Bridges 64bit PCI
hole", 2017-11-16), we meant to expose such a 64-bit PCI MMIO aperture in
the ACPI DSDT that would be at least as large as the new "pci-hole64-size"
property (2GB on i440fx, 32GB on q35). The goal was to offer "enough"
64-bit MMIO aperture to the guest OS for hotplug purposes.

Currently the aperture is extended relative to a possibly incorrect base.
This may result in an aperture size that is smaller than the intent of
commit 9fa99d2519cb.

We're going to fix the error in a later patch in this series; now we just
add a test case that reproduces and captures the problem. In the fix, the
test data will be updated as well.

In the test case being added:
- use 128 MB initial RAM size,
- ask for one DIMM hotplug slot,
- ask for 2 GB maximum RAM size,
- use a pci-testdev with a 64-bit BAR of 2 GB size.

Consequences:

(1) In pc_memory_init() [hw/i386/pc.c], the DIMM hotplug area size is
    initially set to 2048-128 = 1920 MB. (Maximum RAM size minus initial
    RAM size.)

(2) The DIMM area base is set to 4096 MB (because the initial RAM is only
    128 MB -- there is no initial "high RAM").

(3) Due to commit 085f8e88ba73 ("pc: count in 1Gb hugepage alignment when
    sizing hotplug-memory container", 2014-11-24), we add 1 GB for the one
    DIMM hotplug slot that was specified. This sets the DIMM area size to
    1920+1024 = 2944 MB.

(4) The reserved-memory-end address (exclusive) is set to 4096 + 2944 =
    7040 MB (DIMM area base plus DIMM area size).

(5) The reserved-memory-end address is rounded up to GB alignment,
    yielding 7 GB (7168 MB).

(6) Given the 2 GB BAR size of pci-testdev, SeaBIOS allocates said 64-bit
    BAR in 64-bit address space.

(7) Because reserved-memory-end is at 7 GB, it is unaligned for the 2 GB
    BAR. Therefore SeaBIOS allocates the BAR at 8 GB. QEMU then
    (correctly) assigns the root bridge aperture base this BAR address, to
    be exposed in \_SB.PCI0._CRS.

(8) The intent of commit 9fa99d2519cb dictates that QEMU extend the
    aperture size to 32 GB, implying a 40 GB end address. However, QEMU
    performs the extension relative to reserved-memory-end (7 GB), not
    relative to the bridge aperture base that was correctly deduced from
    SeaBIOS's BAR programming (8 GB). Therefore we see 39 GB as the
    aperture end address in \_SB.PCI0._CRS:

> QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
>     0x0000000000000000, // Granularity
>     0x0000000200000000, // Range Minimum
>     0x00000009BFFFFFFF, // Range Maximum
>     0x0000000000000000, // Translation Offset
>     0x00000007C0000000, // Length
>     ,, , AddressRangeMemory, TypeStatic)

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/bios-tables-test.c             |  16 ++++++++++++++++
 tests/acpi-test-data/q35/DSDT.mmio64 | Bin 0 -> 8947 bytes
 tests/acpi-test-data/q35/SRAT.mmio64 | Bin 0 -> 224 bytes
 3 files changed, 16 insertions(+)
 create mode 100644 tests/acpi-test-data/q35/DSDT.mmio64
 create mode 100644 tests/acpi-test-data/q35/SRAT.mmio64

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 4e24930c4b..9dd88f9d86 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -708,6 +708,21 @@ static void test_acpi_q35_tcg_bridge(void)
     free_test_data(&data);
 }
 
+static void test_acpi_q35_tcg_mmio64(void)
+{
+    test_data data = {
+        .machine = MACHINE_Q35,
+        .variant = ".mmio64",
+        .required_struct_types = base_required_struct_types,
+        .required_struct_types_len = ARRAY_SIZE(base_required_struct_types)
+    };
+
+    test_acpi_one("-m 128M,slots=1,maxmem=2G "
+                  "-device pci-testdev,membar=2G",
+                  &data);
+    free_test_data(&data);
+}
+
 static void test_acpi_piix4_tcg_cphp(void)
 {
     test_data data;
@@ -875,6 +890,7 @@ int main(int argc, char *argv[])
         qtest_add_func("acpi/piix4/bridge", test_acpi_piix4_tcg_bridge);
         qtest_add_func("acpi/q35", test_acpi_q35_tcg);
         qtest_add_func("acpi/q35/bridge", test_acpi_q35_tcg_bridge);
+        qtest_add_func("acpi/q35/mmio64", test_acpi_q35_tcg_mmio64);
         qtest_add_func("acpi/piix4/ipmi", test_acpi_piix4_tcg_ipmi);
         qtest_add_func("acpi/q35/ipmi", test_acpi_q35_tcg_ipmi);
         qtest_add_func("acpi/piix4/cpuhp", test_acpi_piix4_tcg_cphp);
diff --git a/tests/acpi-test-data/q35/DSDT.mmio64 b/tests/acpi-test-data/q35/DSDT.mmio64
new file mode 100644
index 0000000000000000000000000000000000000000..a058ff2ee31a22a55b5b198bc1531c7f20b243f6
GIT binary patch
literal 8947
zcmb7KTW=f38J*=#t05&VrL`<y5)n$!v}rDs<vK;%1SWSWk`Y&;NIG#q16;dtD<v(m
zP@E!Z5I|OdT>MZVWfQbOALxMpqxlJWYk&d;`r6l^h@YaKZ)QiHSyDi(2XemIbG~oR
z?ChN7uKcdw`*w{n>)+KKuhA`4ueUuPeHLSk+Vt%-GdEcO(6819Rz8)n`gil9jgPAB
zKI2!f)vdqog<pi>osUE7X2foN>3n|cX7u4F;Vnj>cWy<TQ^VQfgKl-uKk|6nYnJUn
zqv;naUvt|Yc(RqY2Nl1=?7_9BZ@I0R!A{r9+<TLG{;TVw?d))`xWt`)@UM;URxe)t
z;?+BquU`D;Z|=RxGXPw|w~g<Oh(5yiL%tf0oIelutq+JUj;)WD{yY?iWuHSwqL6y-
z7i1TuS|7jZ1hyP&&2F@7JvCMfBgEJ+AB}b|U<Jm${yxt#{ksmuORv<n{ZhN*4@&Np
zLAO_75%q)-b=~}9$enOh_-q)mVVFNY9<$N>XTzK9FE<P9KmW^)*_bb2COX|>k<WiL
zi>XI)mSOBY=3Je5j)p_ihUv>SyOn{MDhyy1gK0NAyD1*>LjSOZGnnFsJk`H@j@r!I
z2`Xu3;j4<TR=ek?1ge(eM}#^9RE>F++P39Y@zHAI!?}9)`LwD?)%r)zc6uI)%5#>-
zIiiuS@H2HQVi9vvYs{)!2kd~Qa__PJ(F<Eu{{)^+yR%|GP9zFq$U<g;^*VbU-)ku-
z?H@fA>|8q`E-WR9HqWjxhk!3Z%Ly>U+!Z<FH2!du!z_>4{me;0htJimchm2tZF}ud
z6slz~C+kX4){0kMoQ5Xkv@{RW57NwDb3~d=N^>cZhNskUXiiVflX{Rs9vgY=cGKHr
zZef6LE83&T`O|9_odU=Euee;=onCu!>+QqEd<LtBwYIlvOtvkwH`!u=`gsaLT?J_b
z4YoL!DI6c;VwSi#A{K!2@|fTOszPESzrdyh6WBN+rh=xJU;-+b2#JZ&2y9v~)d*<)
ziL3&emP|lZNK91)>t13-o{V5BXht&C;1TLNvxd&BU@B-<GS%P_>N<0V&YWN>XwKA$
zP}ezQ=$tWh&X_t8>N;&hr)}u8O`QmJo!B9?nVvOt&YC(A>N>fhlN&m@sS}~DGjHh3
z8#?o*PK3Hn>{QzMEEqZqrcQ*q&N)NpoS}2h)QM2nIdABkH+0UMIuYtR7Yv;XhRy|3
zCqiAPW9W1YosOv!p{}!N=qwsKi>6M5y3R#I=c1u=(bS1h*STcqTrzYnnK}{bI$cAj
zYv^=Mod|WEXAGTZ44r38od|WE%ZAQnL+7%o6QQp2tfBL)q4TV%6QQni#n8E8=v*;%
zBGh%B6U<7y6P^>yYP{K<lT7bnNK8M*o;R514d!{1iBM-=Fqjt%<^_|9P-k8=m=_J^
zMU#n8XFg^yA2XPbnM{N_^KrpcF7voxsy+U3$y6IRLSiZ>Sv6{|8Z}qVnh0f08wOg@
z47A>Do){?FC>$Fo0+f|O8i6Vb1C=;oNfz#R1W-9<N<vjgOeGBlDzVByH7FUVgbF4Z
zC_;=z8K}g@5!F;)O9m>TCkBcTLl;;WsKmw*G1cUffl8=gl7S*rI$@v^E0{1)4N3+o
zp@K;Uicsl<fl91k!ay}B8K{H`CK)I~r4t4!v4RN$)u3dc5-ONvpa_*t7^uVwCJa=A
zl7UL7V3L6%R61dx5-XT6Pz_23Dxrc&28vMWgn>$|V8TE(C>f}P3MLsSLZuT1DzSnI
z1J$5ppb{#WWS|I@P8g`f3MLFxgOY(ts9=(TB2+qIpb{&XFi;Ij1}dR~Nd}5g>4bqw
ztYE@GH7FUVgbF4ZC_<$Z1}d?F2?N!jWS|l%m}H;`l};F_#0n-1RD+U%N~mCxfg)5o
zVW1K#m@rTcN(L&Sf=LF7Q0at$N~~bQKs6{CsDuh887M-f69y`=f(ZlFpk$yDDwt%T
z2$fD4sKg2;3{-=Xfl8=gl7S*rI$@v^E0{1)4N3+op@K;Uicsl<fl91k!ay}B8K{H`
zCK)I~r4t4!v4RN$)u3dc5-ONvpa_*t7^uVwCJa=Al7UL7V3L6%R61dxh%^I5q#Gzg
z-9Qm)2C6Y(pc<15RAZ8XYD^fY#)N@tOfpc7Nd~GhVW1il2C6a1Ks6>AsK$hWYD^fY
z#v}vPm}H<D69$S%on06xBAhWXnPi{{aT-)eOf|PKP(*5OVW5cA+>(JJRC7xPiqL27
z`2j4HjS55YV|7eFNbl$9tJ1&wi|5nyE0vxV(9;O3-Px_cad)fq;n9b0GdvsFtx<cE
zKI-(*u-&ERZntNRX5Z(Bdw2*kJLY-!a&y<~%mUCU7w38Y(;S<nhf(;Ye2@Bg7N5=N
z{XM?GsD(jv@MNSlgL{OE`Ym3-;}m*WV`JFe;xb?Qbe_$o;cg83H^WYhZ0>@5E<r=U
zXew@T;5WPM18Va_(X&8LI@p*7B;vD!Zl`PA+l$9Q<*7feUQJZTV}&1Fy{c8Oit1I2
zPp@8er&q7`j{?%}C93n(Bb4{F@}4N~CCYoJl=tHDezH6sm;GS%zE<8B<^4o?|CI86
zT)vhppLvAxHLZM2l&>Yq*G?&4i_32&%V!^<{H9iZQ<UFKl;1q1{AOIfo-Chxgz|N*
zd|i~UC(74PDPNDvH<ION9-(|gE8h_18;SCbQ_43`K0{ksvb-b9tIY$q74(=*Jhe3Y
z+?=@N@kQ5loGy78^P-s!_Zk!FWZ%?u6W8UUnGQD~6X|5%)N~Wq*^-$KcO?_)WZ%?u
z6W5Jvro*kuL^|0wHQmH@aK=oB`<IDyvTtg-iFLhfro&CmL^|0wHQmHIJ!_`Joz6r$
z*=MG6sxQbl1RlTf@L74gQ|qdg$Z-L}f9AaQwNm4)JJIjn`EBXo_S<j0bMWiiZ?nGT
zwOd>9ik#!TZhceureGEDXdAu*L(G3uzytlePf$={C6AuVd(G{x<#mErEU)%**<u;b
z3w*nOcacD8uUl)Cfb=W95*{Ttx0`mvsIz}md*+6CgMhKf@y%7dcC%bwFVhI*+n20c
z^m?1GrAB<X$3F7P<?_DU$a$zf+kfK5^BMI%fHczBkB_6hWH*XMEF7I5CJ)f)Bfb#!
zpPD$*+8T#$kR?TrR>(@GLWZgN-NwAv^|tNPWLV*smHaTon~X4G$)uR!Q9UyuNSp~w
zR}zlNx1x!W0UcT4{jJQXF_}u7&*`andNLQ_$TeMPFzfAfdxg`4PCZ`}gN5Q~e~PY%
zr;@z{eIwb4DVRFC{)aEos=@_^KP*tJEPG7r3u`c_^on_IGyI&V8$EX(@BVsu62tcP
z-@qk$Jz(wyEaG~*HmH>^;WUXCRJ5S!++yF(YS&@VXv<A<uD#tZSISpVg098j_V3?1
zc(1fKaXCt75Z57Y4>?<*>#)%dIu?G1^OgQl<3)J|A+y}g6Pf*H5R_iO{fB+Jxb48-
z?%-AFbK2C<kSJj~=u}%Jd^GUUqE-v7_Vq!jfA^Uw_zJtqgIafB1+?S>S}Z~B<pHuk
zIR%{#XcGu_YOmm<>y_Lkaf3UW9nz5SP7HU~eJf~rTg<KG0?ZtHcns^m{{$U7KK}Ao
zpNGVVLP|JV8p`TerMOJQQ0^~}+@Tx}_0meE=pdxENlC_*`)oivnU*&C+a41M^FyIY
zZV3V%x|NjxH@nya<Pa3r4mwvZ7dLqM-cK1T;FXg3_x-W_Q@wF`jGqcb<ntJLOEwqL
zY{=%1S~b=CG@5bma!|P*W6z`6i0CvCi5e|Rghs1D1ZuP>$pLj!gSZrk!^9rBpHm+l
zKcLtWokh`U-8t!@R*R0cM*hr@y0Lyb8<&c!{Nl&3o`;f2D#;{?Lf*zD&XIlqO=!-8
z8#k9Rpg}~H>2O5J>0m_Tq(ku;BHBsw%4PRSti!-co`8r}r#h*j`(rGuUS<NcPm3;k
zgI1kP>8@d&mQxczv3w<@f3%Ye+GYGN09~Brcd<Dr_beQ$J3v|#bR0456=PacaZJ0y
zn8qyPMcOmcV;UaC*f(5fKt4I9fru`*7+|r+7Dtu$wM}J1Z7Ot))1~3KwB3ji#eRv6
z#HlaHok0E*0|r;T%K6_vnPVwDqocD!A9$_(pzxqz+32_A8T<~19~4gFIdLw()z2`;
znWf*Q^p|4di1^iu@T=qFe|#?vu&-X4yb$n&S*!~2Zvzr0KCzwRZU+A|kbw~SFBge@
zi~6<O68zgkufp@%c38@lau(jWJ3qOBlhfT8Eaoy6hK2U!!J?hvDURxhenv;As`JZ-
z6VyL?Zu3=7-V)C3)`Dv=fJ=l<RB^ISmTrEWo$L+q*1MjS|Lu_Pmdkj}PyZLvKYF@b
o{<#b=mlnf)YIohorbdlRs<A<h{?S5rJthL1Vs5VOZTHy!0aq7uc>n+a

literal 0
HcmV?d00001

diff --git a/tests/acpi-test-data/q35/SRAT.mmio64 b/tests/acpi-test-data/q35/SRAT.mmio64
new file mode 100644
index 0000000000000000000000000000000000000000..ac35f3dac4f47b86e41c7f35ee40bac14174b37e
GIT binary patch
literal 224
zcmWFzatwLEz`($0?d0$55v<@85#SsQ6k`O6f!H7#gyBE{mCvXFmw__4-~!0{5bA&i
cfWZfLm_qF8V6xb0gn4lH?0~6chB1IN0P8^t0RR91

literal 0
HcmV?d00001

-- 
MST
